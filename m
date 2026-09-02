Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2D441D64E
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788386785; cv=pass; b=gpkx7txUzbaLoUYpNZM2+rPqn54ZwKXdpd9ID95OcWzxuYuNuLQ/kXVpAiqxz5ent++nKAv+0aERCLgVnYOcnzGSIKHrFq1/so7SrtFcF3iWNucE5nKFxEkPWTaETxGExKexVF5pEk67oztMmUp/1bjpYo4ZS+ygYAjtmYM8EPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788386785; c=relaxed/simple;
	bh=+NgXSrxVyEIpCGdMguA9GDbqbBHK/Rdp7VKcczzfwCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZz3Ev8Lo3JKtywSfJVWKA3aohOTjdVSdttu6aVXqdYSTSmJIdx0EQTRpaeE4yQgipOl7CHEW4u4+UVD3FZw8Q57T9V180Z1wdH8qfzYkiU4cTOQjM3jF3q0huFoZvG5/5SEBmyuIJUJzZgqndF5zcWa0EDUZDkMV9lfwznQHPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNx1O//1; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNx1O//1"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1c3d79b9bso1314712a12.3
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2026 15:06:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788386777; cv=none;
        d=google.com; s=arc-20260327;
        b=oGZ1f8tqRXqxlQDmy2RK7+TSXVNKe2iXqBAGrravKrxW+ngLwDwnqciWehtmf1ITm4
         UoRpntyH3lZN+wutfOObMlo7GCGINOmpM7dkcnOzCY6IaFNxfjRYKdyzMg6IWEU1DFSg
         kxFJIeoUhaOSkXkRTI8QhJn1iCQVFA6L5zeHqiX4yS5JHmwQXiXPXkZ8UdcJwCCbQGhn
         U45AS8Rl3j47aVaCAoK7Jln/LtXr/WWS9+vd7WnuF9pSOi3xq09P9afkep4CDC719xSL
         c92vBP6+jVBP4fQKGVZlxVe2ZNgXSv7VJIBje71O1cDY5DeaHsAkoaef5vup/+GEE1l3
         4OGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+NgXSrxVyEIpCGdMguA9GDbqbBHK/Rdp7VKcczzfwCE=;
        fh=Kjo9NAKUxhkuzTfi5WpTZBK5lNwvrklaN1SBl6qUPxw=;
        b=bfKWRvBuJexJb+nAog4WLXx+qEE002SVyo07v0uCaq55wXReCUfEHWhVq+lz4Q5OxG
         a9lcH7srv6ZYQEzZFNYb1WWxSCW0do285D99FXSNBJjJ+aRjl5LvR38Q4VUu4xVZcKa0
         zGd2HdLexTUHr1cQ+dbmMCEFEOYB31zag1oeJsilD5BXFaf4CQf2C7DHHkdmYoz3h9Fi
         TM4v8CFaiZw0s6cwPpUPCnDjWh5fk6gavCR2W2cuwEjikj3Unr8QFXUFxp+nf0dx3ySW
         wbn8re0+87+radz7haYmfUq+jH42jOLkWgKIvM1gxXbYmplNdVtdBOXZ0C/YSpJdDuIs
         9iZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788386777; x=1788991577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+NgXSrxVyEIpCGdMguA9GDbqbBHK/Rdp7VKcczzfwCE=;
        b=XNx1O//185bo5oJhbR+1pS7HcmPQ8VqyJLvZppP5AcBmiWfvOeAUfTEXbDkcEIwpCq
         YyD40mRtdLuA6tl4mp3k2hucHQzQNNZsO9+z5EBjiyiPoir0NIi6sx8sBuuPlgs+BnRl
         /8qW03ikbGMIhrFXDE7wUCdDWQSNMvcMMXW+Ys96Xn9eaS0aO1qQrc9kDBZ9T5QiKr5x
         oCKeRAbP7DBpN0xiURINIqDv8hYW2dJ39Oc3OXwehN3tTFqA4uSvST5gp7M9C2PVmskG
         ypixCIws2RV+Y5havBK6maAih+oFMLDR0RKQ+5wxUXugO8kFJPD7+2xRkVIugJhKUVXv
         M+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788386777; x=1788991577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+NgXSrxVyEIpCGdMguA9GDbqbBHK/Rdp7VKcczzfwCE=;
        b=am49q6NmWpJ8ze/7bwCboUUrzkxrCQ64iWML/VaNJw8OoXNiZwng2wfTaLIEwqV7Ff
         L2ENnj2jn5MpyJFRwGeZFy4c2bVQoZvJtDeMLWvi+lTSqAVDEP8vMlyF7qVMLBXagBZP
         AZKGoRuqExgnpS5SkQTseU8Oa+S6O5wzy49QW1GLcrX/zhOrZZooIrkATarvwvmsMMpS
         0AUhT6lJaxN4ALw7gLA5Fg9EkEKbmmUcdJNTqcSIW5udCUKmd71nULkDCTEQeZkc38Y/
         JKVUTrPedZ1qGFWwGtjBb27QqK0oYjsTlbNxTF7+e/wFz5ztZhO5LQf8+b6Z5RQMksp4
         Jn0Q==
X-Forwarded-Encrypted: i=1; AKwUvBy61zyLN58pZv+4t873574EyEzeGMSnocgKT217QJmv9E50YIbnOgVAcXeNaPt5LYbG05w=@vger.kernel.org
X-Gm-Message-State: AFuF++lQm6M1P3rZyl47/2iHgvZft2BCnWYCpdoqphbEQng3YhdWtS5s
	5ZSWN8KiWHzycBBSRozV2jrAOgwv0FmxmVrEyPbS+Xt/BGu4zBQJrcRmLVWzbfzW2g4D/ADMG96
	28OD0zmce3jtgyfBWAlgx35FxhbA78EM=
X-Gm-Gg: AYBFou2UPVObx3ygdn+B7ViuHA9z5EwuY+GFWdPl+4fddDCHOe4aFKRzZKCw1rJgtqI
	SmqOLEezKokzi/ylDo+ZtMyLqyKZwCeVavNn28vjT1K8wF6GROcQ1vXXI38TlBXD8p+vkW6Ip8p
	hWrT/hQxJ/oaT2fGFJ9g1tZlHsSUAxe1Mav3Y+MZKiTqJagtFWhDuWeRPOujinER/5h5erAFPg4
	w9Yji1n7TsnaCEOP4jI7yi8ntapLSNtL+tG9uxR0gUsdFQGJtg+LMwbPXd0gXmBvK/cGiSwyxpY
	T4YoY3GiqZ79M9ZbM0Ba798SSq9waRf+sizXqRcxf7Xn79qNuZ+WNl+PpXw01ozTWNIwW00jbG8
	ENXcQ1PcDxJGwNeKpkVELv8j9aMvu
X-Received: by 2002:a17:90b:35d0:b0:398:b46d:48c0 with SMTP id
 98e67ed59e1d1-39aee10890cmr12235245a91.18.1788386777209; Wed, 02 Sep 2026
 15:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819122252.1782790-1-florent.revest@linux.dev>
 <DL27QZ6SEZKT.1CV2HAX4A3WI4@gmail.com> <CAADnVQLxi-R1KDUXJJjpq69SpV8UcNJVqBi7uicO=V0WhAvyQA@mail.gmail.com>
 <DL2S878KSOI5.1SZMLIAWMCNUJ@gmail.com> <DL3FIBQNP6AU.1HO08FMI292UX@linux.dev>
 <CAADnVQLMm43qJxuiHUuuh51wAL4kH0+fRoaM7YfbZEXT7LHn0A@mail.gmail.com> <DL4R2YXF9J8G.203VBANYFFSET@linux.dev>
In-Reply-To: <DL4R2YXF9J8G.203VBANYFFSET@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Sep 2026 15:06:05 -0700
X-Gm-Features: AcwNN1WeWzPoWWLVPmmE7d-k8VTitECGoYp4jtQLUEttyXIwHXv3qEmj5Sw6KYU
Message-ID: <CAADnVQJ+OJKmgaDM9B58g30M_-pkZgGmbDuvEWmrg8U_ZkxbSg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Keep progs alive until the trampoline image
 calling them is freed
To: Florent Revest <florent.revest@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	John Fastabend <john.fastabend@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Jose Fernandez <jose.fernandez@linux.dev>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 3:15=E2=80=AFAM Florent Revest <florent.revest@linux=
.dev> wrote:
>
> On Wed Sep 2, 2026 at 5:57 AM UTC, Alexei Starovoitov wrote:
> > On Mon, Aug 31, 2026 at 1:58=E2=80=AFPM Florent Revest <florent.revest@=
linux.dev> wrote:
> > >
> > > On Mon Aug 31, 2026 at 2:43 AM UTC, Kumar Kartikeya Dwivedi wrote:
> > > > On Sun Aug 30, 2026 at 3:21 PM CEST, Alexei Starovoitov wrote:
> > > > > On Sun, Aug 30, 2026 at 3:41=E2=80=AFAM Kumar Kartikeya Dwivedi
> > > > > <memxor@gmail.com> wrote:
> > > > >>
> > > > >> Overall, looks good to me. Thanks for the fix!
> > > > >>
> > > > >> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > >>
> > > > >> Note for whoever applies this: please add Reported-by: tag for S=
echang as well.
> > > > >> Optionally, wordsmith the commit log with the suggestion above.
> > > > >
> > > > > Hold on. I don't think we can proceed with this fix.
> > > > > It defeats the point of fexit jmp patching and keeps progs
> > > > > pinned until a sleepable kernel function that were attached to
> > > > > will return. Which means that the tracing prog attached to "unluc=
ky" kernel
> > > > > function that sleeps for an hour will stay pinned for an hour.
> > > > > Let's think of a different way of fixing the race.
> > > >
> > > > I don't have background on the original commit being fixed, but is =
that really
> > > > realistic? Or worrisome even if it happens in practice, since worst=
 case the
> > > > program refcounts remains raised for that duration?
> > > >
> > > > We have similar worst case for programs too (e.g. using bpf_copy_fr=
om_user on
> > > > user controlled buffer in, say, LSM progs). At least here we won't =
be extending
> > > > any RCU flavored GP.
> > > >
> > > > That said I will think about alternative fixes in the meantime, if =
we accept the
> > > > premise that we don't want to pin program references in the image a=
nd keep their
> > > > lifetimes decoupled.
> > >
> > > How about having old trampolines skip freed programs instead of keepi=
ng
> > > them alive ?
> >
> > Isn't it doing it now?
> > That was the whole point of patching nop to jmp in a trampoline.
>
> Just to be sure we're talking about the same thing, you're referring to t=
he
> "ip_after_call" patching done in bpf_tramp_image_put, right ?
>
> My understanding is that this only helps in the case where a task is in t=
he
> traced function while a prog is detached. It'd make it skip all fexit pro=
gs.

Right. That's the one I meant.

> But if a task is sleeping in a fexit.s prog for example, it is already pa=
st
> ip_after_call, so this patching would not prevent it from calling a secon=
d,
> freed, fexit prog lined up after it in the trampoline, no ? The same situ=
ation
> should happen with a sleeping fentry.s prog followed by a fentry prog.

Hmm. You mean like fexit prog A called a sleepable kfunc and
another prog B is attached to the same trampoline.

Then the trampoline needs to be freed. ip_after_call patches jmp in,
and trampoline proceeds to free progs A and B.
B is freed right away.
Eventually A's kfunc returns from sleep
and jmps back into a trampoline
which is not freed yet, since percpu_ref keeps it,
but prog B is gone, so it attempts to execute a freed prog B ?


> I have a reproducer for those scenarios that crashes bpf-next. I will mak=
e it a
> selftest in v2 like Jiri suggested.

Please narrow down the reproducer (sounds like it's a random stress test
at this point) to specific steps.

If my guess above is correct the reproducer will be short
and deterministic.
