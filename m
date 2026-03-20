Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6482EBBB2
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025862; cv=pass; b=XgcClWOxQHVQQxnOkFnvfBJ9+/3bjI2vl8gwnWdLe93ckXVyorFwUu4RCXcOxB6zd8O0EUSvH7vlPqwpRZnn+Clj+9xi24zF4jcg6HLVIFrjRycIznzHES/ejMC5/FFYzE2i1iiKOvAe4jLIltCN92PRAkDQGmMGmOXwnnsiTKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025862; c=relaxed/simple;
	bh=YjTO5Q3z0EClm6azl1u2wWsKT9tZLVln21IL46od4AQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llNGLENA4tDAoJll7Zq/BxClILA/LQbvMN7f3ma0DR6W25uiYxa68huQf0vHrGD25mz/FI0GNinUCxUM4q/7bNZaG7ozF8v83s4d/YQorM3ZGKqRbfHE2Avieo3xZ8vFReBK3Fq0etbLaMRZUq0PQ31Zk+k2JIVr5U7r6HIYYn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWOcoS02; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWOcoS02"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79a5fb98316so20537367b3.3
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 09:57:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774025860; cv=none;
        d=google.com; s=arc-20240605;
        b=hVQAt1HZYcwuHbpmLazzg967VnO32l7jLDvHInzN3Z/MdPI3Zg3svCTLIu6GacgzPN
         raXoQJW6IUHS5udzy2WTg8JiTJCuc8+yzg0RBxQPIT2tyk8Gf0p34q1CqilZqLaJpNQS
         Lex+vZXNXZB+RWiSvNnh4LFcJOtMCQdKInNnN5+HTzRIbRaAPWn8nzeZk8TnLtWEIjk9
         TW3brfMDKmJMLArdEQ1s04rVuAqMIfQOw78jmNoYjxUxjGdXYF6b+TitTpn4hwM4xg6S
         7QPyLd5Ij09IuWu/1AanzRXCJgHxj05QjRHpL9buungghpas1wNY8TxJOPpHreMRGZ2W
         RuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VFs5pg+EOoBonRDSGJWl01bvRPjx/A7Fl/2yDgn/cVM=;
        fh=czn8edMbHfajPZz82YWRUbaAzaYA2SgTN7wqc6OUQfE=;
        b=ZRs2h5EndVNzVaCq02y87jSg6CqJdAhaed6cI5Zer/ElgO/qJgvkYkuN+3uYVBLs+x
         t8M6o0J6TVT96+6C+5GA42MnKyhilsDEF1yrHPvH70Ihn6ZWDvVkBwwUrbjaaVdY1jno
         eE0hsvy7o7mZlTL4ROLtxDUQDTZG+o47vJI+9eCxohPVSsp8xIu+o8FUFVdr8YTMRqYl
         fsekeUKDAHwZE6pdwRjRxbIajSDZKng43H3TIpZ/y7IMHpaomHiibkKCUsZSEmwSVqmc
         zp6wjq6lSMz/VtIXjmb5jQlvqtS87Lkxwaoc4mGsDLxyXyvQ0RBJ0YuyEbRFneE5mOFf
         dswA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774025860; x=1774630660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFs5pg+EOoBonRDSGJWl01bvRPjx/A7Fl/2yDgn/cVM=;
        b=SWOcoS02olL8ordX0SAYfuwguGsVRLImK1oDF/eqnerI156wy2dF5hsfQeaIX/soTf
         t/FI9HYnxD5TwLGtXOP6ehYsIAAf6ZNy2mTSt1k1pXdVuVlHShR/yoDBE9V5IEDoAXq5
         sx90sHv6VHSCuDkjzs86g/1TEDSRtCOmOthWPFpMkImIz/1krzVGQm9U6NN7rBXDbllz
         8Z9BhKxQjcTBJdO9jD7irNpHEaivEgvc/Li669Mun/avDHR5CSmjlFc2+6ujEv6Tw7BM
         oxXTpOEiybR1HxCOjVn+wB/j6mX/Ai4kga1dP8ZDzQvfRzXIW2XCVO8Wp/vqQt+oTp6d
         FscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774025860; x=1774630660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VFs5pg+EOoBonRDSGJWl01bvRPjx/A7Fl/2yDgn/cVM=;
        b=NeqevtjsMuIbRLjitrnVbvtKKf6AsHa+5meNsOrIQftB3wsLsteRuylntr4yWZYeTX
         cRvaOUH0xj33F1l3VcThTbD/inGNst0ZdW0ahEXts00/wMtqhqAz4GHi7zgv3u7bfXAS
         /KaqJS0ZA1y0kotiET2OQpI0smVsNXVdnp6uASw8juvEYtlB0vxgMMCbEXTJdIgdOvbB
         zk0xe0Nhl9++KadDobAcUiK6vD1uO+0UMnjvdTX0ESdmC6cwPHJO95zwFJaINX0JrBGW
         +sPD39USF1sW7ECeNstWAr03+xndQ/prSG04T8oC3w3nWvu2n5n7slm4nUvahLLPCp2F
         Hmow==
X-Forwarded-Encrypted: i=1; AJvYcCUYgkQvZ3ZvXEb3pD7M8GiRSEDv8F5jOLOHz2N+zB3KCXRlTq4PfBAISHgB3E+GCymlcvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdwnxYZmO9Tk4KLUg1MJEZJRFLYHS/LsMyyPqUxe+6UU9grXEP
	8J5MTattQUColfv1NM/pTLWGkEnLj7je43Txy171IWTPeVzP88dw8GudWwlEQYd6VbGTKoybNw3
	fj9kUxhtcn47us3RPixnyTah+W6RZGPM=
X-Gm-Gg: ATEYQzwzFUVpZXNJDBnqYjdmCjuc1vwR9ajF1aSgQCe7xHDsJPRZy7YRwoZFub1tKqj
	kg3gflL3VI1bQSSvIzcRZrR6BS2833VwwdoFHiMe0ZM5IcQvZ7dqnS3tcwE81y5Rlmf1YqJ1Q0d
	g/caw/pqbemk+Loj/NH/ANk6c4zlI2laRz9ktZHN1WpH8o89HZ7KVKjdm/0Jhfot/mF9iMePlfw
	RTqIuOKhS+N4Fqve4f74CPmVsP9t7JBRhJCU/y/maCsVmAiUTYKQeRT5CuKcdX2xR0OCdrAQT48
	4HNabT/WDWAZdA==
X-Received: by 2002:a05:690c:c4e8:b0:79a:440c:fbed with SMTP id
 00721157ae682-79a90a92a80mr42119077b3.13.1774025860240; Fri, 20 Mar 2026
 09:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320130219.63711-1-keisuke.nishimura@inria.fr>
In-Reply-To: <20260320130219.63711-1-keisuke.nishimura@inria.fr>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Sat, 21 Mar 2026 00:57:28 +0800
X-Gm-Features: AaiRm50wHG5v401T5wFU6vTWOPHcfFg7b7vBLgm1IIrE_MSH_kL532Ybic8u-Xs
Message-ID: <CABFUUZEH1SNJ+TOc=6N9+BNnPi0rH4ZQoHEdwLtj9fkDJSnsjw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix refcount check in check_struct_ops_btf_id()
To: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 11:47=E2=80=AFPM Keisuke Nishimura
<keisuke.nishimura@inria.fr> wrote:
>
> The current implementation only checks whether the first argument is
> refcounted. Fix this by iterating over all arguments.
>
> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> Fixes: 38f1e66abd184 ("bpf: Do not allow tail call in strcut_ops program =
with __ref argument")
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 159b25f8269d..278443118a23 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -24853,7 +24853,7 @@ static int check_struct_ops_btf_id(struct bpf_ver=
ifier_env *env)
>         }
>
>         for (i =3D 0; i < st_ops_desc->arg_info[member_idx].cnt; i++) {
> -               if (st_ops_desc->arg_info[member_idx].info->refcounted) {
> +               if (st_ops_desc->arg_info[member_idx].info[i].refcounted)=
 {
>                         has_refcounted_arg =3D true;
>                         break;
>                 }
The fix looks correct to me.

Maybe it's better to add a verifier test for the case where info[0] is
non-refcounted,
while __ref is stored in a later entry.

Reviewed-by Sun Jian sun.jian.kdev@gmail.com
