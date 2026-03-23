Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCCE303A37;
	Mon, 23 Mar 2026 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774292524; cv=none; b=luGIUBIDzfIrDKeP8jCUflSGLDPQ7CvdDgF1/oXWvd1ChFFP/w9onGkK8EAp2EceAz+1VD70xFaYMoCxzyJNfLr7cp7NwE5DkiR8Ip3q1uKB3cSei9hqVHP3vjgwrIxoL4Fh3UgzJ19qO4ltpbxjmfz+J/zzf3mZAfPibByvyLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774292524; c=relaxed/simple;
	bh=IwrSWtGi2v1DkqFTlr7GsesaD5m96uCr8RsRD7i9kXM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OYawsVF0GRyxs9DD1Mio2/FPAK6eTzInP3kRls+8aHExW8qe5WywZP6tq8EoZne9k9zYsYv+VZskA+YcjvGFtU3hC9rJf4JceHV1hmab4+0fAzmipB46n+qZ9nBdEhdfP++j0g8+LrO4sj1DT1/BfGlf5ecHEben8UmIwLo3oys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qDjXNoSP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qDjXNoSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9B2C4CEF7;
	Mon, 23 Mar 2026 19:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774292524;
	bh=IwrSWtGi2v1DkqFTlr7GsesaD5m96uCr8RsRD7i9kXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qDjXNoSPFa9vqQcYPFHo5QBuN9qbSdcVciNaX5z7tIjoerpVOhqIG3qOBnXy0wElU
	 bFM7RJYtwa3xrc7YS0cM1NsIpADp5QVBTEfLRJGD+WzfKyesme5R6ohwdjWZ4NtUi9
	 rCYk1cyu5LxVFxKfCWipoxIqXZqsNS59mNmeDwiU=
Date: Mon, 23 Mar 2026 12:02:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jeremy
 Linton <jeremy.linton@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Simon
 Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Vitaly
 Kuznetsov <vkuznets@redhat.com>, Philipp Rudo <prudo@redhat.com>, Viktor
 Malik <vmalik@redhat.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He
 <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
 kexec@lists.infradead.org, bpf@vger.kernel.org,
 systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7 00/13] kexec: Use BPF lskel to enable kexec to load PE
 format boot image
Message-Id: <20260323120202.e662110de3ca696086f9e1f9@linux-foundation.org>
In-Reply-To: <20260322014402.8815-1-piliu@redhat.com>
References: <20260322014402.8815-1-piliu@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Mar 2026 09:43:49 +0800 Pingfan Liu <piliu@redhat.com> wrote:

> Nowadays, UEFI PE bootable images are becoming increasingly popular
> among distributions. Currently, we have several kinds of image format
> parsers in user space (kexec-tools). However, this approach breaks the
> integrity protection of the images. To address this integrity protection
> concern, several approaches have been proposed to resolve this issue,
> but none of them have been accepted upstream yet.
> 
> The summary of those approaches:
>   -1. UEFI service emulator for UEFI stub
>   -2. PE format parser in kernel
>   -3. Signing the arm64/boot/Image
> 
> 
> For the first approach, I tried a purgatory-style emulator [1], but it
> encounters hardware scaling issues. For the second approach, both
> zboot-format [2] and UKI-format [3] parsers were rejected due to
> concerns that variant format parsers would bloat the kernel code.
> Additionally, for example in arm64, both UKI and zboot format parsers
> would need to be introduced and chained together to handle image
> loading. For the third approach, I attempted [4], but since zboot or UKI
> images already have signatures, upstream maintainers dislike the
> additional signature on the Image. Moreover, for secure boot UKI, this
> method cannot use signatures to protect the initramfs.
> 
> 
> *** The approach in this series ***
> 
> This series introduces an approach that allows image formats to be
> parsed by BPF programs.

AI review has a ton of questions:
	https://sashiko.dev/#/patchset/20260322014402.8815-1-piliu@redhat.com

Coverage is partial because some patches didn't apply.  Probably some
of these questions are legitimate, others will be false positives -
we're still figuring this out.
