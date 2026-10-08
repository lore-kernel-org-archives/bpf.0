Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710633B0AE4;
	Thu,  8 Oct 2026 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479609; cv=none; b=ucMSLduvp/EBoz0z99nF4+KyMQQ5+fLwHzZeqQWlONVTdyu9BgjfnUDhN+kPeaP1q0YROMu3E+E6cyD9+cPnj/B3HCbeTo3LWK+5NUfYPAMx9+bTfKedOrDbKg8KzKoFsMfWq729UTRzDcUEE8XPgArs8y78eYzclnlSNHeoHPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479609; c=relaxed/simple;
	bh=R+N9wiAO3Nd5/Cw59xWltmx5Y4wb1achXpslW/0xbEg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JFs40zNJNvg6PhqcTsggHEFjYXiqQT7VbefsLeyM40J86e5Rm2QF3Ne0RsZxjGa3K/DKWL27b7D1eTIe4kvglgFqrJ+lVuq1iVkxUmebe4MLHWGZEunlx+cd6XhNPQk1XSlCcxmCpLEAOOkzrTzhuIsjLAwGRqQEtLM1gr1WDh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrCCt2WM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrCCt2WM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC361F000FF;
	Thu,  8 Oct 2026 17:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791479608;
	bh=4Nab+5mJ9I+wun3TJcQDZJ7WvF2Rq36ItMB4cHrsCKw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OrCCt2WMVt+5aDSsNmHg9N/DS6J17uoRrJpnBlMklFqEPqd6ZGzjcLG6I/O7BlrNJ
	 MPbzUTd95Bu8+j+VH9WHxvGZXAxWyb0PXJqEbbytQ7NpHX/fqqjhecraYDbXt7dYKN
	 TyA74hSzNwedDkFNJQmrTnaZWIr0CuFaCmR23Qr0gYN723FYNnvLSeDtExfvWSu0FG
	 ivdlD7/6gmh86JzGR27ksOQIl9LVNCAWepVxBf8gujnjZ6KUzJQeg3KYnxX7Tbgt8y
	 e4FDcmssbPqFm9fdpvVDrcqEkxD/50Arnk6Gqn4J4Gr6PGWdp61tuMCWYCIN4c/4Jk
	 o0TacztWTBiRg==
Content-Type: multipart/mixed; boundary="===============6176424161200003919=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <960fca850e45c39ab84ddde9b0063a89dc44d9faf0e3e750fec9e9d891f773a0@mail.kernel.org>
In-Reply-To: <20261008161309.8179-2-janten@gmail.com>
References: <20261008161309.8179-2-janten@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Revalidate iterator programs on link update
From: bot+bpf-ci@kernel.org
To: janten@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,jakub@cloudflare.com,jiayuan.chen@linux.dev,kuniyu@google.com,willemb@google.com,shuah@kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  8 Oct 2026 17:13:25 +0000 (UTC)

--===============6176424161200003919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Revalidate iterator programs on link update

TL;DR: Nit only: Documentation/bpf/bpf_iterators.rst may need updating for the
new validate_target callback in struct bpf_iter_reg and for when it is invoked
(BPF_LINK_UPDATE only). No code problems reported.

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 0ecb9418dfbd..5aa786eba3ea 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> @@ -3024,6 +3026,7 @@ enum bpf_iter_feature {
>  struct bpf_iter_reg {
>  	const char *target;
>  	bpf_iter_attach_target_t attach_target;
> +	bpf_iter_validate_target_t validate_target;
>  	bpf_iter_detach_target_t detach_target;
>  	bpf_iter_show_fdinfo_t show_fdinfo;
>  	bpf_iter_fill_link_info_t fill_link_info;

This isn't a bug, but should Documentation/bpf/bpf_iterators.rst be updated
for the new member?

That file carries a copy of struct bpf_iter_reg that listed attach_target
and detach_target exactly as they appeared in this header before the patch:

    bpf_iter_attach_target_t attach_target;
    bpf_iter_detach_target_t detach_target;

It now lacks validate_target.

The field table in the same file also describes the callbacks as:

    attach_target and detach_target
      Allows for target specific link_create action since some targets may
      need special processing. Called during the user space link_create
      stage.

Nothing there says that validate_target is invoked only from
bpf_iter_link_replace() (BPF_LINK_UPDATE), and that a target's
attach_target has to call its validator itself at link_create time, since
bpf_iter_link_attach() does not call it generically.

A new iterator author working from the documentation would not learn that
program-dependent checks belong in validate_target as well as in
attach_target.

Should the struct listing and the field table describe validate_target and
when it is invoked?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37809581821
--===============6176424161200003919==--
