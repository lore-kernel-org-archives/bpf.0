Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E755013B9
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699387; cv=none; b=qIE9VSbajk3B/AzI2hWP5Hh/OTzldDsxjDD3ipmhpdgukC0siCgTadbYfXjFQvEOeMNn6yMixMEmXSzuxwM+VEQlC9vb94dsoZscJ5vscKGiUMw/2CUWHb4WvoVAAKcOWRARxeAa7Ew/fCVn0+eE6dtO1b49WPg2pIqaByEiD4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699387; c=relaxed/simple;
	bh=1v42kf6QbSA3YM4j5AXbRMkgXRvycLkyiH4QtoAzOWM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=HkQb7xKF+90PTXMzF574JbRQdhr38/Uk0mExXzsOGhdql6jMStyRZmxun3QiLfvHECEuzDgIiR2xTdwwxbA6mKoUZXLL+ftGPJxbPjBeZfGgo4gr/SCuGxwLwfUpLKj7wCpFSFdX1T6RNRoo2rg4rxDRcAWuRLrFeUBCgM9phLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6xx2Tej; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6xx2Tej"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4d04d73b8so1714531a12.1
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 09:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790699385; x=1791304185; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5gmBRPrdCcT1/ykMZonXArmE29LxS0sCmqHY0q+fG44=;
        b=L6xx2TejdRqIhaBrMBIb3iOcbTsSSHWSDFs4OCbNfSBPxKXKZXh9T9erFgbQ9iJYws
         VVvau+elTqmwv1S/n6WNBbzLZAyRENxuZzxBzE/Tlm5ez/eTjf+400gdvuQoSpUyp0rP
         q56037nOmS49ZdG09AaforitURhLYLCyasQ8AJmC+6gp9D7alAtaaFqWLP0FGzNTlFME
         WylL/WvQBlkW9dRpVKKSZvaU67xwbp3E89K+qUACRTQhdh+/KO3Zqzx/qw0M29aNtc/C
         aRldIGDeOOjr+B6mhe6nb+QLP71NWsQUl9+aK1mSijOeI6oOZXAXY65YdaDs9fpQ7lsi
         MW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790699385; x=1791304185;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5gmBRPrdCcT1/ykMZonXArmE29LxS0sCmqHY0q+fG44=;
        b=07AgXdRL31OM7g4UHi46cF4u+cgw/8HtE7qWZDKvVuLh10NdO+zI3O7ssSJC6o5P7K
         BnLqZFLRLY0qmY7uejje/z3duzeom/RMaEopWjV3z/wRKCk20G4AOpgjumjHTcZiST0A
         HFD0ujbT3jiVb707riJC/fumvP/nzca0idjISzJJqvH3fLweW0ZwBwtKHGahZZUfJocG
         fAIwoNgfqEHSpFXVxmS9yBLfdg0dmUww/GBQdjUzsBjlUacR9BGaGxHQ7BHSwWVL1Nht
         UsFUv1GRibzxHz+PIxsnZXeJLvg7JwpPkfE6MaSexcdEHQrLJ/gZE7wzgkGnqCE1jvAH
         G6jg==
X-Forwarded-Encrypted: i=1; AKwUvBxZBR8jqCghr0jOkG7QFevA/FclsyKFiEZFgmeQ8zoCXE8Hl0wCTF1AQJOv9BZvNVoEZjQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjnTHBk25UC+dqzpoIj0KsU6bcEtuNtTUyxz3Wx22LrUkeq6+2
	qIKeHa0T505f5HLWQOQpwlAyOaqp1NTYqiOOoTVwpq1mIH3U+K7agX2q
X-Gm-Gg: AYBFou1HsgzysyIfHA5/PNesVdoZnTNgkWPz8T9SPxPJ0lELLB1j3/7gFhrX0mYCOJc
	W9WP+t09x4hTgbkdXVtK+XQ6uGGxwS29HjrOX+wJjBMIf+9xsD0MDyaLDD0Ma267+hXXojZ8oBT
	VVSzYiW1EtCefdq4qI1Y8qWD7IFQCDb6cGLPy5HNjgZu0Vp7b/9wTQ/eJV2gwxkhMTP1TcNvVXm
	yNkuOCit0GTGkPHFFShGx11uIW0RCOZ2hC4Ap5iLFDWgxolxb9e3rcl4tUJALQKvDE5s9JH80uO
	rkdAnL+hkAL6owpFfhJOUXC9K6VDxGPwPBxpPfdJx9YbQi0FfaLEpzpHnxMWa5F32vV1nCBW48r
	A7NW/ZPrFlijkHa2GpogLXNvyGvvWjgZHaTaR0gvwkzmuurReZO4smldfbA7uDGUqGKmkpR5oWW
	NOvCcTzlREIGknoJbogAxcAzU27VTyv4STWH9qFCKuSAyevf+G36P8n7GJ6y6m2OIPUz6xWCvva
	/KqwuICgG0qvAgw6HE1rGz4xxv2VcXY9gS8mNolGRwKamkOekVEQVEMBzN2kbIbgHGB50jSXbuR
	jVI=
X-Received: by 2002:a17:90b:4a89:b0:39e:6c69:34da with SMTP id 98e67ed59e1d1-3a098fc84eamr14040423a91.62.1790699385067;
        Tue, 29 Sep 2026 09:29:45 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a498596aefsm7239381a91.6.2026.09.29.09.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 09:29:44 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 16:29:43 +0000
Message-Id: <DLRXYC55FZOH.3CRQ4XBJ7K3CV@gmail.com>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Puranjay Mohan" <puranjay@kernel.org>, "Paul
 Walmsley" <pjw@kernel.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Pu Lehui" <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Update DENYLIST.riscv64
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Pu Lehui" <pulehui@huaweicloud.com>, =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?=
 <bjorn@kernel.org>, <bpf@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20260929083924.1851840-6-pulehui@huaweicloud.com>
References: <20260929083924.1851840-1-pulehui@huaweicloud.com> <20260929083924.1851840-6-pulehui@huaweicloud.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, Sep 29, 2026 at 08:39 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
> diff --git a/tools/testing/selftests/bpf/DENYLIST.riscv64 b/tools/testing/selftests/bpf/DENYLIST.riscv64
> @@ -1,2 +1,4 @@
>  # riscv64 deny list for BPF CI and local vmtest
>  exceptions					# JIT does not support exceptions
> +probe_user					# kprobe hit in trap
> +stacktrace_build_id				# kprobe hit in trap

stacktrace_build_id is already in the generic DENYLIST.
