Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998594;
	b=tWGzmBeUGM3ovF3u0DFs/yMLbKbxwjOHrHB/ONeDw05qHQVc7yKm+gY/rOg+fseOOyCF
	 i1hO5fvE1eBcfPL0PVFP+UOIcpRhjDPihbVJwHKyXij1Kcqqab11Rc/m5VCiWTP9OeKxx
	 HQOlMKEhnTEd9VyTQdZPRuxt6QttYL2qf9jyBx6SRw4694QlZyTFycECWtrMQpwKEeZMU
	 OQOaoVSFBoft8WAqBWXdyJbcAvwrhhDb+QMSpqHa9TvPsOYK6xhM3uPkczSi0rEigp49M
	 l2l4D9cB5rLN/TejEnJZeOSXIgzoJK9xC2NaFDJ3suGJx0Nb4qQRPt7dArSP5nrNxLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998594;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=LmbsQyOPiObeVQ4Oyywc1Eh0zv4uea6QG51XLaUXbO8=;
	b=S6hCknlsQzXIBceLDcwjFOvCG9t1DUAE8DUADaNyhF8XTQjI+xbXJL+GOdo6qy0cZMXf
	 zgj5IwVA7lGNHUI4IGe0NCyFFrRkGU7tOJx857n1PuW1EcUrljG+pwpXJMtjXYBRpxXSA
	 tR/MfszshE++4c0zQNUyDUadUrxP5QIv49aHjxAbkUtj1PfQ+7lSETQG2spCRdXnbh2ql
	 Knno34l5cufR8n3vyoT18M5Hka9WimZFEiv9v3OitwsXd71lWe5p91KyV6jpTEL8/QxUc
	 +NdGNkQxBfhJI5ylNgRZMKeG5zrPyAmgoHAYCQTiG6tdSkYTd91uez0v1599wQLIEEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PlmlLxV+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834DE606A336;
	Fri,  6 Nov 2026 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PlmlLxV+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDB11F008A5;
	Fri,  6 Nov 2026 20:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793998594;
	bh=LmbsQyOPiObeVQ4Oyywc1Eh0zv4uea6QG51XLaUXbO8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=PlmlLxV+8BJ0T4iY7wc+r36eXC/XsgkqkA/TUWWk/Iq70scU4hUHfUroR+bRZKtaF
	 2SXLYFj7/vmljm343Z5ZunP0QwMnYtSFJMoGk56RlVXiPgyqJh/A0oUVJ9POR4BvGQ
	 /kUHaTBsHvbcLI6KYObVmt+Kzome8s8XzaEvBbWbtsXWcN6fc1dOn3xxCwiFDdYs+F
	 8oFFpFBs1/k2zioXBa3aNLCPULddw1xj9GRlhXqmC4EkclmjR6AvqvhbAsmjfC4MZP
	 pM70gZqYimyQw+2fu8sH1TzSn6Y6DH00QXBO8NyGW8LLxqifa/kElzX3gRWpFNrrTG
	 EuRRFyOoxBrsA==
Content-Type: multipart/mixed; boundary="===============7211679506512085853=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a60379dcab142fefbf17dcfafa9e9aa445a1458da82d15cf31214fd1783c7a6c@mail.kernel.org>
In-Reply-To: <20261106-lskel-struct-ops-v1-1-a4486ffc79cb@google.com>
References: <20261106-lskel-struct-ops-v1-1-a4486ffc79cb@google.com>
Subject: Re: [PATCH RFC bpf-next 1/7] bpf: Add bpf_btf_get_struct_member_info() helper
From: bot+bpf-ci@kernel.org
To: sidnayyar@google.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,qmo@kernel.org,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,gprocida@google.com,nkapron@google.com,tweek@google.com,mripard@kernel.org,sidnayyar@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri,  6 Nov 2026 20:56:33 +0000 (UTC)

--===============7211679506512085853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add bpf_btf_get_struct_member_info() helper

TL;DR: Design question: the new UAPI helper is added despite the frozen helper
list, which says to use kfuncs; syscall programs can already call kfuncs, and
the commit message doesn't explain why a helper is needed.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h

[ ... ]

> @@ -6279,6 +6291,7 @@ union bpf_attr {
>  	FN(user_ringbuf_drain, 209, ##ctx)		\
>  	FN(cgrp_storage_get, 210, ##ctx)		\
>  	FN(cgrp_storage_delete, 211, ##ctx)		\
> +	FN(btf_get_struct_member_info, 212, ##ctx)	\
>  	/* This helper list is effectively frozen. If you are trying to	\
>  	 * add a new helper, you should add a kfunc instead which has	\
>  	 * less stability guarantees. See Documentation/bpf/kfuncs.rst	\

This adds a new UAPI helper id right above the comment saying the helper
list is effectively frozen and that new functionality should be a kfunc.

BPF_PROG_TYPE_SYSCALL programs can already call kfuncs, for example via
register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &generic_kfunc_set) in
kernel/bpf/helpers.c.

Is there a reason this needs to be a helper rather than a kfunc?  Perhaps
the generated light skeleton loader cannot resolve a kfunc BTF id for its
own call instruction, while a helper has a fixed id, but the commit message
only says:

> This helper will be used by BPF light skeletons (gen_loader) to
> initialize struct_ops maps and programs against kernel and module BTF
> at load time.

Could the commit message explain why the freeze is being broken here and
why a kfunc will not work?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42289585064
--===============7211679506512085853==--
