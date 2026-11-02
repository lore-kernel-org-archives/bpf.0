Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793652972;
	b=L9bXZrjRJUln8rt7fuHFB7YJMqptwUob35h4NCS9kl3TpfWDkJXOYQfFXU5u9+PjZp1v
	 RPBDlWFtF8SrBcxNZBhsu4fa8+F7Tln9U1pHEpUqF0CiEEH7UvfRTdPYuyZr8+KiyT2ML
	 ijsMc/3WRCTJjipoCsq4oXgcvmIrvIEjm09uCxuBk1n6rvub0f9oXjWq8E3Nlq2UD6jfb
	 IFRYpufPHYzVsbx6JTLBGBBo/UN1ckVZeImT5pAU2c6JVjPQOO6S8qQ1TWfF3lSU5rnhI
	 MH00LwbuO91ROf5LlVLONoPDeHAZ695eTW6LJy7Gtj2yddTsnsryZgP83Cr9Z0kWmpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652972;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=HsuW0zkka+Elv2x6CDanHdbewieZdeCcVAGWkuyiZ7o=;
	b=PBEIZqIyVCO73wXy6ZHNG2GAAO8Zp3g8ZRyRkt75oCGeSuZ7b0JSjnz8XKuKtFK1Kn6n
	 QfmVA8bdQ/GvKj4QPv/ONVgTht42eONPlcuZtkbm2VEstvbfWgR1LuEdqynLBmLzGAD/e
	 wdXlImzgL3GGRqILblLte7XE17B/fPPf3WAiJ9z5kl82q7h83N7DuqqdViIBwgW1wro4/
	 +VS+SFvhDg92YnObz29iyau7GRsalffXSwIfNEZ4BdpLqsvjJ9GVpisQjCF0BFG1FotIp
	 XcxvlKhYRmGVpfCxFZ343qQuKgIvn+PD9PW//pkagQ9qYVZ+X226SooCeE+QbNVcw1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIm21m70;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163F606A324;
	Mon,  2 Nov 2026 20:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIm21m70
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276391F00A1D;
	Mon,  2 Nov 2026 20:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793652971;
	bh=HsuW0zkka+Elv2x6CDanHdbewieZdeCcVAGWkuyiZ7o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aIm21m705nl4REoGkhGon7dGkJJtzUcUmnorQBcFE/A+yTQnPUbarOXwsgv0Flprm
	 yjWK1ePrXcngarNPUqzdfi0A11QrRVdEjYUGE0ABggfgwrU7ivO7ZJ3tO6qH459ge5
	 5ZQzVbZV8SRUY1A+qVwlxQVBjZr4nitoVdG+s0WEVdUW6ucgAPUV5TfqJ8UIjzlZn/
	 keNxwp6bG6k6qEnik8jywaL3CfY5uaTaLE6/BQMPC5rn8A+wRroF8vY96Vg5enecPe
	 TFin223iQYALEZ4hHeKhPTVS5Mh2Znye2c4ju/liikPkPnHOQF1UqO+Rn3mkiHjp20
	 PRPJ35E+fAn8g==
Content-Type: multipart/mixed; boundary="===============4408330301857523369=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d6f3b8857bc4575bf2467f95f84ffe8475e2009bb43932644ea0dda53a561827@mail.kernel.org>
In-Reply-To: <20261102201356.5798-5-mahe.tardy@gmail.com>
References: <20261102201356.5798-5-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/5] bpftool: Add attach option for light skeleton generation
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,mahe.tardy@gmail.com,hi@tychen.cc,gyutae.bae@navercorp.com,sh_def@163.com,josef@toxicpanda.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  2 Nov 2026 20:56:11 +0000 (UTC)

--===============4408330301857523369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpftool: Add attach option for light skeleton generation

TL;DR: bpftool bash completion for "gen skeleton" may offer "attach" as the
object name after "name <TAB>", since there is no name case before the
catch-all branch. Minor completion bug.

> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index a28af31937ad..9247a9fdcaef 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -1021,7 +1021,7 @@ _bpftool()
>                              return 0
>                              ;;
>                          *)
> -                            _bpftool_once_attr 'name'
> +                            _bpftool_once_attr 'name attach'
>                              return 0
>                              ;;
>                      esac

Does this completion offer "attach" as the object name?

The skeleton branch of _bpftool() has no case for prev == name, so when the
cursor is on the OBJECT_NAME value it falls into the catch-all *) branch and
runs _bpftool_once_attr 'name attach'.  The 'name' keyword is skipped because
it is already on the line, but 'attach' is not.

So "bpftool gen skeleton prog.o name <TAB>" now offers "attach", and
"name a<TAB>" completes to "name attach".  That sets the object name to
"attach" and does not request loader attachment.  Before this change,
_bpftool_once_attr 'name' offered nothing in that position.

Other value-taking keywords in this file are handled explicitly, for example
the 'map create' branch has a name) case that returns 0.  Would adding a
name) case that does "return 0" ahead of the *) branch for skeleton restore
the previous behaviour?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41519963115
--===============4408330301857523369==--
