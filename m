Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D0F2652B2
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 01:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789694999; cv=none; b=fI9feF3X75lWZMBYqJu2ajLnlgvtGs0Csj6dOoEy2ENOJF1jwBJmpcVrM6AIRlgav9YnMv+K/xWDThHUQWfGk3Qa9OU5kifwJApDZDPreyoCcoom/ytaJKLEwT3ua63F7nswR99TrdilZs6a8xTkEGxswLLkxPTaDRqmpFUzsos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789694999; c=relaxed/simple;
	bh=iI0zBzfG1hsDHz6i6vCemlZH6syFW4P/KDHxX9QZmH0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=Oi8XrdS/UhyNJ3Gb+UdMBYy/IiX+29Jq9BVF0ssIWkCE7kvBl/ASEDuzhGlyysx37f7LKtruIDVcUOdWS12IHm7/7kCtXEglRV15Ve5Sk6ThNI7nk4G6q+EMWaI/byMtH0jwPYbS0H+3ifhN/0urXwKWPlbdV8udZkA7FhG8bXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDWb7+RZ; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDWb7+RZ"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5121bcf1aso110252a12.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 18:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789694997; x=1790299797; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vbHRw9e+J0REPOf8TNkwmKIHKyLdrdPDh38QRnbIRiU=;
        b=ZDWb7+RZz6kDNMTMVo45vxMMmT4lWY8ib4Psim9IR/7F1UrRdLLvZU41bjagMzVUge
         isFKXUbZ0BjxvBg4hdWHm+h3RVaCIJscz/JazMhxGsV5JAv9QAWDbKNTldZZyjY8JYtw
         2e+j7lUiRsAGeM9oYCsi+OlMEvTvnhGl3ZDgW6Gkfy0WFEohVN23djw1rgwxHfJZoHNq
         031kCx3EAR0hsWDpsWt+DXbNOzGXB0ch5un5zWjuLBwjotojhddFrI3rqzN6IHMRP+cu
         rSrsbz6cy1gp6bqcNoqJHNhLta/VRRMW03AIBtefJxqFBwjRYlCcpE8GDFKrKGbteD3H
         ZONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789694997; x=1790299797;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vbHRw9e+J0REPOf8TNkwmKIHKyLdrdPDh38QRnbIRiU=;
        b=NOGxMb/rWlMVJHfyk9cywZpgnv0S7SMmwabeQrYLpa8U8K9tw+MQ84qhWMgqNGvbf8
         VZHyaohhffPhFL5PqqICuo0w8ybwHWRpwZJRR4bMPte0eqttIrTgQMM2v0hDEaOvtG8s
         kc+JGxSY84ZT/3QEFND7c0sdjV4tJYRxGx6zPQXzfxz6q6N1aYrvd4zEWk6FIkIpyACH
         Tzi81mctLn3j2yVUNuoHgPGwG9qdDhrfzxhYJ8dUhdvlToTQNN+i8bcEy14rd++oK6oT
         P2WciMF2UfzFzVwsP6kqyiRu97L1S5G4UA7o1z0Eg+wtYXvsZvn5hi3WqbXDOMpv2HFm
         sU7Q==
X-Forwarded-Encrypted: i=1; AKwUvBy5F+ebrcjARRW0lkCkG9vbeqGpP+OflyyHJxqSB4zOOhSG1abIxKsRMBkZrk+4ou5OVnM=@vger.kernel.org
X-Gm-Message-State: AFuF++kwyftICkLK+gKhGTTC5AyJK0yghHKRSge6ZuTYVFFwyIsCI81A
	fxKcxCkn0sPH++dgJC1bCXYd0X+88fqgI2ILuW8MjVTUt732FPIvOtkg
X-Gm-Gg: AYBFou3akjlkV9iRxT50m6AoZG7WrVQaPM8N0eBX6XIzNo/v27ZiZh2ADYARqIWZBF1
	2jWf1LQpqgZ86C30OQ8kMq9wxCoMtSOtpAu2OnHnJZZxYS9CAiN1I/eK8A/b5qsq2LezOK+MBzl
	Y0krNhv39toSbTCx9xDamd/isouPazaacnUYxVRS0HSbduS0dkcEJkKYoP0USf+g90QXp3geF7/
	riyT7fUKzzpU85fnur9jXukWWhQCsvKfub9UG0z11K5/u95hKeNOfsDW7HbUL/n2p7kS03MBh7k
	U6vh7w/4pJd7n/nrf8vcVcftjVev6wOsZNQ6m4inv1Z3YX+W4ZZYEzVdQmtWLMi+PlBC62geYYI
	ekaU91BEDjtC28uJKcishccBiXn6Zder3GwWDm1R9FwpaU6JOUZMIMcbrkJoGrmmA9Wvy7SMh97
	rTnuIm0C3YemZyRsQ4WXeJMGVkd+p9YPix0ZZRQeE+qQaT0cliD+7RZVvm1i7FL/t2s1oRk1ETZ
	hPCNZAt9RlgU7eTmDoyyz2jtwmC1yn8jURkAxw9S51hZVS27Hr04J5E3a0dhozrEjuwjbsoLL1w
	Qw6q
X-Received: by 2002:a17:90b:3f84:b0:39e:4c7e:f042 with SMTP id 98e67ed59e1d1-39e54f91d4amr1930776a91.31.1789694997537;
        Thu, 17 Sep 2026 18:29:57 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e36115cc8sm7493789a91.3.2026.09.17.18.29.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 18:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 01:29:56 +0000
Message-Id: <DLI1XF72KLXJ.3JTQWV4WFT55P@gmail.com>
Subject: Re: [PATCH] bpf: use str_plural() in diag_print_history()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Lalit Shankar Chowdhury" <lalitshankarch@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "open list:BPF [GENERAL] (Safe Dynamic Programs
 and Tools)" <bpf@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20260917204648.9110-1-lalitshankarch@gmail.com>
In-Reply-To: <20260917204648.9110-1-lalitshankarch@gmail.com>

On Thu Sep 17, 2026 at 8:46 PM UTC, Lalit Shankar Chowdhury wrote:
> Use the string choice helper function to simplify the code.
>
> Signed-off-by: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
> ---
>  kernel/bpf/diagnostics.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index 0abbbe177e31..ff139777ac64 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c
> @@ -2354,6 +2354,6 @@ static void diag_print_history(struct bpf_verifier_=
env *env,
>  	if (log->first_seq)
>  		diag_write(env, "  %llu older causal-history event%s not retained beca=
use diagnostic "
>  			   "event storage reached capacity\n",
> -			   log->first_seq, log->first_seq =3D=3D 1 ? "" : "s");
> +			   log->first_seq, str_plural(log->first_seq));

Nack.

Instead propose a revert of commit 9ca5facd0400f I will be fully
supporitve to delete this obfuscation garbage.

pw-bot: cr

