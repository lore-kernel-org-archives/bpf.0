Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0381DF75B
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 01:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782090378; cv=pass; b=atwj5gpX1k2s+fDw4UZEVz6ak2nLnElmm/6QK4nwTvipigSrS+L3eNUH4pH4U51M+dmkWrQNmixy+SmUw5rkjezUCo94xNoxL1ApSkn5by9G/4u5nXBYPGV93Nm+mlzodtnRAup8f64vMs10WHz3+H4vm8M6EYqbfzaeCN6GKXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782090378; c=relaxed/simple;
	bh=fa78JVsUMI/xMlejN1x+mciKuyDJGoN/339ipw+N1ZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbhHUkwjkcW7V9nQImWduiLLMiY4jWY06PPtogKqUevXMZIs74tJqPtH+gbh0Yj1xZcYVBamcClolzhiYzTibI0kCH+E8RmFRtBbGN1wyJV4r7CqM3gaTpliBeZbK4qu3DruEEiBFGQIRDYULK90RoP91JKt2CwmbVnTa2muD0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wz6pmMC1; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wz6pmMC1"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c892935bcdeso1436272a12.3
        for <bpf@vger.kernel.org>; Sun, 21 Jun 2026 18:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782090376; cv=none;
        d=google.com; s=arc-20240605;
        b=Ep3qblsp5Yq8I8Reg0K+oGlRqyisXrgMzMEl6WZXjxidP2UVPrifzM5XSlrI1DcF0Y
         biIqGdewGYKmWEqyYcrzg6ev5fdIBBiq9N45Hv2p+xZ9a280uPbmNrwJL6yR/UitjcT6
         u3agvaBHE8KRKOSSW86E4x4THmG7KCKHHE3tSnHcFe/DpQGO/7szN3T8lJFdFxvj5PfP
         JjxsyzkxEKn9Z3uz/3NAWDCGtz/T/483LLMX6WCsB8saSmj0NR58j9VYlYxCMP8X02NW
         POoO2fCXPo0fbh6/EkfYgQgiNNN4mLuJguvcg+VdzuIwo23LVw4IVUmUYgLUu+aPFLKx
         Mu4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UxkCtHGSizaetEhdwRDWvcIIrU2C1fVFPinUW6ftVtE=;
        fh=79FgU+edHAk1Vle0VN4Y+1XE1Oc9J9nVOCQ0CwA3dvc=;
        b=WWiuDCN1bhseagUXD0G2EmOzTk6oI0lJYBSF9QrB9QUKKF3AlfO/R0ycypKprQqwn3
         THmnW+2k/BXrrOmZytPECKdgQKgd6ZrU2AL4SsoRQB8fICVtMLM3jmelPRJ+MbAKV5Os
         wh2bam/kcU4HUY6GubXsgx9ZKf7JS+D2Nvf4kOGcazVH3ej8hnUsnM24OV30yHC33HiG
         bBJJrUvv6fS9WSwDs1v1CM6FyGRKqRp4scR3T1gw9Js6WPkSIvezGntPgkNaHfiQ8399
         iWTFHot5nmsTgBVeuq4yV7c+IVC6sjVa7KKu0SINNfyROmRYIm1qdP174Qq1XpLgnq0z
         BYnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782090376; x=1782695176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxkCtHGSizaetEhdwRDWvcIIrU2C1fVFPinUW6ftVtE=;
        b=Wz6pmMC1wBXmWW7rBhhJ4GmHEQpBQ0u0+Hc4ba5StjkrThkvwSIggdVhhIggywLIy6
         GZgRMV2XBTY9YkIhJ8sfjmaz+i1Od56U+2Hq/PnCMQhND0NHd9UBJy6j3jzJhh83Wgks
         56mhZKwKsMg4Lt861XmqGCJ1tpYSyvvhxMN5Y/rsKnIf7HUbyTs4WZ8F58YvP2+5OAFr
         1rpeFOTGykWjZ2o9/NJrC59kkvFpqNrViHnKkbtJdLEVnawVDS2jKYI+/eWVdpkIOqY0
         NsirLSd6Fx9NMmx4usLJJH/A95Ya9qF0JPlRgoIQMR0rIna+RlMgOyQBAKR0u9FFYE4A
         JgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782090376; x=1782695176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UxkCtHGSizaetEhdwRDWvcIIrU2C1fVFPinUW6ftVtE=;
        b=Hb+kGu4fDtG/dIeqI0xyj78UJ6kZ9oruRTHV2ZZzgDOaTpqEpi0rtiqpnwSKM+kn69
         CG27VcPZWW8yEOelRVAywW4rclfB6ONT4TGPnsX8A6PyTqXWlPYL3naXUBFdjZuJFXdQ
         EyASRnfzraFt6TyOVPsyzzKucyvqK9FiEuvEf7D5P9TOa4GEIUgXlA9fF48161SOOC1g
         lZltO18EXQXVXFD0zSFq7/SgNA9UOdXhE3QSQrYiF8eQBjNh85bG5c9gJ0yf5ibd2SAw
         +aUDXmtYDfjtoW94lLj6N5rx9vem9HhVrVEX5zEwrBErl7D/HWm9nRWxc+SisWw7QzMt
         EgdA==
X-Gm-Message-State: AOJu0YzkfA0wni721ICliUoAusTh5ovmHhVR4aXpVkDDPrLQdbeYM6PA
	WPFnyhFL7eIU2fqkWHWQc+CcBgpEAedQX/6879iqCEwJxeCvSbYAmsiscPjMQffZwKidoTWw44y
	cfRsTIkg1wAFhXPofwQ/PNclpY27Y8/vFtQ==
X-Gm-Gg: AfdE7cnog/eWCMjp0CCVNJ035OMdqAGbO1BAF0sU/bPnDiVy+xCVHxYSjn1kJBKZHrj
	Tvw/2vKkWWgQWTXMaS8L+1+q+rVGdGYwO0faoSZjPoAyiUqAdpugTjmTkrbyVbSBs08xiGZbZuL
	gcgb5JmMBr7dmPRuOBBBiOlR6UgSTLVofitXroAvyozLPDv1De68sSQvfBddnY6/L5VMUPqXn9M
	UTx9AA4ijEtAwbKBV1RlzZDyQHtxsPTzrKf2FOluaZV9MYVaVwGES9rH/ZWQRtZDLAFO+t1REdu
	HmDT/50Wzc+CqQqoSR8PdD5WKorYgjyIcN8Md6gu2SMhdRedL37V3wQYJtaioMqPGQQ6bBj+ZkB
	v4/S/7o2UOtaG4g==
X-Received: by 2002:a05:6a21:3418:b0:3b3:be1f:c89b with SMTP id
 adf61e73a8af0-3bb3506226amr14656757637.22.1782090376108; Sun, 21 Jun 2026
 18:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d6622225-c765-4d9f-9501-1021df4687a4@web.de> <DJBL1JEE322B.28EZ7GUNTJP99@etsalapatis.com>
 <451a504c-d7c5-4cbd-9184-25156f2fc581@web.de>
In-Reply-To: <451a504c-d7c5-4cbd-9184-25156f2fc581@web.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 21 Jun 2026 18:06:02 -0700
X-Gm-Features: AVVi8Cd-8AdTmn982XzsO0dW10ZgSbyAUBqwwZ3qatqgAJZM5UtAYhTCqXHQ1Ow
Message-ID: <CAADnVQL060PFApJ++juj5S6H8OQGFUHCepavrRrizh0ciBtiqw@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next] bpf: Use common error handling code in bpf_is_state_visited()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 12:55=E2=80=AFPM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 17 Jun 2026 21:15:08 +0200
>
> Use an additional label so that a bit of exception handling can be better
> reused at the end of this function implementation.
>
> This issue was detected by using the Coccinelle software.
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  kernel/bpf/states.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 5945956a7573..09f87e2bb1e6 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -1566,21 +1566,16 @@ int bpf_is_state_visited(struct bpf_verifier_env =
*env, int insn_idx)
>         /* add new state to the head of linked list */
>         new =3D &new_sl->state;
>         err =3D bpf_copy_verifier_state(new, cur);
> -       if (err) {
> -               bpf_free_verifier_state(new, false);
> -               kfree(new_sl);
> -               return err;
> -       }
> +       if (err)
> +               goto free_verifier_state;
> +
>         new->insn_idx =3D insn_idx;
>         verifier_bug_if(new->branches !=3D 1, env,
>                         "%s:branches_to_explore=3D%d insn %d",
>                         __func__, new->branches, insn_idx);
>         err =3D maybe_enter_scc(env, new);
> -       if (err) {
> -               bpf_free_verifier_state(new, false);
> -               kfree(new_sl);
> -               return err;
> -       }
> +       if (err)
> +               goto free_verifier_state;
>
>         cur->parent =3D new;
>         cur->first_insn_idx =3D insn_idx;
> @@ -1588,4 +1583,9 @@ int bpf_is_state_visited(struct bpf_verifier_env *e=
nv, int insn_idx)
>         bpf_clear_jmp_history(cur);
>         list_add(&new_sl->node, head);
>         return 0;
> +
> +free_verifier_state:
> +       bpf_free_verifier_state(new, false);
> +       kfree(new_sl);
> +       return err;

This function is full of 'goto's already.
I prefer to keep the code as-is.
