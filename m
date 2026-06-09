Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048982DB7BB;
	Tue,  9 Jun 2026 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015365; cv=none; b=UnmPprZLXHjXdf++YRvYZ4lWzg6OkPsU4q8wqonnb6m/gI8/1wDOpVAtYmUeMQmaNAgDqdXmKBwD8YKUsIC4At7l+WWffEDcmNjkuFXM7BMPzSWOc/faTNagUBDr4y63Sxs61MwQF5wogZ/l4EucI0lJV5wXUrRelSCD3Au6J00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015365; c=relaxed/simple;
	bh=wRcu3WoLpdEZ7BD0wu3ZmAsFyvGFy/Lcn30HBvVhAIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8SureEl5yK/xR/+Iu1aOt98ow8TRzImMAU4FIf8DNmLPhFWfabobm31iAeBlhuUtPtQBaDSkTSMyvjIy6og2iiDP6/fuE0bHm3bS/1tLz5nssM8t9/n89ViRQYeihbKn9CpLcFZ9XL5EU6nizbDVsR4wfiMjGzm/AGwvpLtUhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0sUlJo/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0sUlJo/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8357D1F00893;
	Tue,  9 Jun 2026 14:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781015364;
	bh=FHtJQh32TR2Ep3SS+qJozuZJQQbDjtDSJvrc7SOfY4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A0sUlJo/I/MQLviYSKd2K16Ykg0FbSS9EdD9ODNQR1fEnSHri2d47+wFzkuYDEEYQ
	 TX/2OH+AUTJN+4z/3CPNphf0awbUQYeDYyR4RgRhHCkhgwyaPebqGhlrqfI5GJkSRm
	 U7QP56uk5JDJcCJ6ndu1mnpoAzwbrxzoRrQ5y/7E+pqSpkBxJ2Kxohkz2NqtPNZgXY
	 BxaZ4Trcs585SJJieRG0A2fJUhYv3AhXeCWLil1THrhsarAveCTHxMjR0f5dFcqrh7
	 +VVSIcG/BTUlpchp8b2cm3Jhs9BE289rDrQ89n9ROFNprGl4KGYX+VNzDLGKxciad7
	 SReDaVWwutwVg==
Date: Tue, 9 Jun 2026 10:29:22 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Martin KaFai Lau
 <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Menglong Dong
 <menglong8.dong@gmail.com>
Subject: Re: [PATCHv7 bpf-next 03/29] ftrace: Add add_ftrace_hash_entry
 function
Message-ID: <20260609102922.3c489f76@fedora>
In-Reply-To: <20260603110554.29590-4-jolsa@kernel.org>
References: <20260603110554.29590-1-jolsa@kernel.org>
	<20260603110554.29590-4-jolsa@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jun 2026 13:05:27 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Renaming __add_hash_entry to add_ftrace_hash_entry and making it global,
> it will be used in following changes outside ftrace.c object.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/ftrace.h | 1 +
>  kernel/trace/ftrace.c  | 9 ++++-----
>  2 files changed, 5 insertions(+), 5 deletions(-)

It's getting late in the RC release and I'm guessing this series will
likely not make the next merge window. The first three patches are
rather trivial and since the rest of the series depends on them, I'm
happy to take them and apply them for the next merge window. That way
you can continue development in the next rotation without needing these
ftrace patches.

Would that work for you?

-- Steve
