Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80642370D79
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781297787; cv=pass; b=b6VwI7ekDNMN+DOACFf6nDCqL5jxZac/K/oLf4D5OyfoK1MuQfjhmdJwHQZ0356nWXpCoWQ9R+o6SwufilMmzh0marbCboGX8XBztPeJIJDzieAkg5Xy9nJfD+HwPplkbH6gk5tqBb5vV/yCVR3CesCPjGEqw78dpZqOCOnT1Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781297787; c=relaxed/simple;
	bh=o1Z98/nJ7jVyyyICngZF6anNq9+HcVEdZSRIzTbN7QE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puuu83LlwhDwjn25za0t/YN2gQ8EX3E7xX589bnhJl7lOZRvviT8AUyRfw4ZMy4MGYzw+Ggd5huNn8oS7iQUZdcz4p6N6iE7Fci7GErd8bVmb1HVpFHP+v7JvC4bKjVb2HjU3h4VS4UYnBW6kBTI7owie4OeSv1dIASu6l9QiEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Quenqe3n; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Quenqe3n"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so1462162a91.3
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 13:56:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781297785; cv=none;
        d=google.com; s=arc-20240605;
        b=aEVwEQ6oTitkC1WRHdeGasM91bVxTspUx1DR3UqClTXiy6koCm92nAGgvAgg6We9Ci
         7N6UrfsfmSClfvgehRMuMNJow9oxvh0oW3kVUr7SZuqiXNe8nUvlaKdvXtt56g+C5KGj
         OrWTIwWiSUfm99d8aI0yyg0sH1Cr4bgW/gfz1dDXtNiPtD3WaV69dzy0VkpfFnvSckyn
         E6S2iaN62ZNAKU1V64CbM9yh4anktP12NLRxeWVL6yjHpfr4mxZIn8iiufaS35f+SPN+
         gNcV+44x0Zp3TP2DpH2bGsufExffNwTVxbNmGay11WoXosp7nspHnUz8DVthwXpw25K9
         /WmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kwWtRMuNkx5q5TeW2ZFjJWS5b24tyd1OJxYTwdo74f4=;
        fh=iabshv16/WD4DbPyB0EaxnMzKX/inUH0A6zTu0VZpmU=;
        b=lBKZPJ1wr71y1CorENyBHSmZu7QG6mHPX7DDNy9MAvOdQu8iAE2Bo9nxSHgq1sYihQ
         3poCCt2wHLUzHxyoWd3SEWTXe7fhP51Xhqp+/+Xpihwf8XhflZw3ef8ZxrDzfxdisqEq
         oFruonsLnoCaBGqjzBunFMRh8o+NKEtJF6kIDdK8HQsZcz9IDv6MA7QahcneXwhTAck6
         xMLvMzGXBG2h1PzGs6ONWwRnIpX6jfRL83xM4MQNwB6BVPcDkCJMGvtfCF2XPxJJkhcD
         G3J1lfqPZGq7wjd3xk3g/Ci5TSEoCbYIjsKqWEPfnVWqaw9OGbSwSLYbwDLBcRolMhh/
         nGPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1781297785; x=1781902585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwWtRMuNkx5q5TeW2ZFjJWS5b24tyd1OJxYTwdo74f4=;
        b=Quenqe3nKOIvR/4gjT63yxMHWUINrfZymwxRJAi3G66786g556xI6M17mzCnm9goYO
         bQlTFlpLpSaRGhypv7adpK5+gl2nv3UkYiJ/Oi148FfZ+YQaa2YVF4E/sExf9x0cIfFQ
         VwQwG8/I9rmfIlKhdUz/oyc7VgAEVT10G+w3wKXHaIBn01YPH8F4imWruhz1swsxu9Ng
         KCAB/MqOvinyTSt/wP2kRMwfdU657slXAIPGH/jVh9g6ZM7e4V/4g3pW5wNBKr4Mk7D1
         8VZcKsVYR32ivYerhgWM9DRJtkKf7Af0LsuwEAJiP+Up2z3ZrIfjEx27Ji2W+YBfqQ0/
         MNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781297785; x=1781902585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kwWtRMuNkx5q5TeW2ZFjJWS5b24tyd1OJxYTwdo74f4=;
        b=UwxGVbYIyO1DmXfC2z2p2CHTpMMb15hEyEkWKVsfI5oORyNaEAQIXDsrA4rNH+vTxw
         WPL0rbX+3VzJUJFagQwiav7H856bn5RjVaWytjOXlVEUJoLQZHSop5g5FgUhZT4RSfs0
         +j6QEoPXfRvAcvICqUqQJfBrVIqDs6wLQ8+DO8oomXSuBzRCTrMqjXx69KdS3kh86+My
         yn8hAr/yxECkDg0S3AW0eVmFs0CmPn/XfRh44o7G/qZEd/0/SuuzPNslTV9qikkcKWvo
         4pFgYlJ1aWmxgW84LEp3mSKOKnrFjUZ37mHW6YEaOqh5WH1yc66hnzlN2osBErFhWAjP
         FnIw==
X-Forwarded-Encrypted: i=1; AFNElJ8SVaG8YoH++6bd3jrOUC4Uy2NZCRvIVpKZv+5HiEl7iNvKrtlxQ6koEmH7hDDjA4SUMiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhuIw2JpilGgwzWPEfCcSJvQCtpXIc7xrHqrDNSBukpz2pslFi
	kp198lWmrW0fIjRWPsTN0rdVtEh3bku1YuAtWQBMca6L8xLMRajI+qcyjhSxtfXL+vvdkNxoUHA
	3oPieFLYvsFXh6ZJHT8Ke5Wgsz6QmmHuyZ0fEm7hX
X-Gm-Gg: Acq92OHx0HVETyUzXMQkp+JvrJmrRQU1MPnurZYFJkCT45FR45UqbHpQwyUFtpFYah0
	sDxo7M0R9EJJjdp2pgDgMwV8XKgEJDDTCizyhUH/bpjeBfhogTxRLd3VWPUQSXsR+qu7XgrGrqv
	cWHmF6b8Moh9omNAyHG0LzJdnjc/cSWTzMK8242F7BTdF9usj/ZuCdSDghYEo9cif1jf3M9N1I7
	EzqIf0K4ivBkc5xWRFHu4O3mQu5WLClBE1K8SZESYoRH6WVRg0wC6vkTplPHn+nxzLwUNU64AuW
	bsW56pGANVF+GYycrw==
X-Received: by 2002:a17:90b:5588:b0:367:d850:6a5f with SMTP id
 98e67ed59e1d1-37c2bd79bc6mr790240a91.25.1781297784696; Fri, 12 Jun 2026
 13:56:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610230329.727075-1-daniel@iogearbox.net> <CAHC9VhTA7tOp16wGzb1QYnkJsVz1X3oNcmT6bb_9334=B2smEw@mail.gmail.com>
 <78107b57-5f4e-42b8-b780-5aebf7362de2@iogearbox.net>
In-Reply-To: <78107b57-5f4e-42b8-b780-5aebf7362de2@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 12 Jun 2026 16:56:13 -0400
X-Gm-Features: AVVi8CdDtTUe3VufUawx7sJnkop42oj_PCA47xW0_AHIqO4_wsh5Db2iGbZWPGc
Message-ID: <CAHC9VhQQKNvP1Who0DdUc0EsVYd_JoSneyzOHZ=Q0MP2qQndCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] Verify BPF signed loader at load time
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, kpsingh@kernel.org, James.Bottomley@hansenpartnership.com, 
	bboscaccy@linux.microsoft.com, memxor@gmail.com, 
	torvalds@linux-foundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 5:33=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
> On 6/12/26 12:56 AM, Paul Moore wrote:
> > On Wed, Jun 10, 2026 at 7:03=E2=80=AFPM Daniel Borkmann <daniel@iogearb=
ox.net> wrote:
> >>
> >> The BPF signing scheme signs a light skeleton's loader program and let=
s
> >> the loader vouch for everything else: bpftool bakes the SHA256 of the
> >> metadata map into the loader's instructions, signs the instructions, a=
nd
> >> the loader compares the (frozen, exclusive) map against that hash from
> >> within BPF once it runs. The construction is sound as a trusted hash
> >> chain, but the kernel itself never attests the metadata, and that spli=
t
> >> has been the recurring objection from the LSM / integrity side since t=
he
> >> scheme was proposed.
> >>
> >> This proposal closes both gaps by having the kernel verify the metadat=
a
> >> at BPF_PROG_LOAD time, before the LSM admission hook and before the
> >> verifier, /without/ growing the UAPI. A signed loader binds its metada=
ta
> >> map(s) through the existing fd_array/fd_array_cnt, and exclusive maps
> >> are already bound to the loader's digest via excl_prog_hash. When a
> >> signature is present, the kernel collects the exclusive maps from the
> >> fd_array and appends their frozen contents to the instructions before
> >> PKCS#7 verification, so the signature covers ...
> >>
> >>      insns || metadata_0 || metadata_1 || [...]
> >>
> >> ... in fd_array order. The in-loader hash check is dropped from the
> >> gen_loader entirely: generated loaders carry no verification logic
> >> anymore, and signing or verifying a skeleton becomes an ordinary CMS
> >> operation over bytes that sit verbatim in the skeleton, reproducible
> >> offline. A signed program is either BPF_SIG_UNSIGNED or BPF_SIG_VERIFI=
ED
> >> with nothing in between.
> >
> > I'll be honest and say I'm a bit surprised to see this patchset,
> > especially since KP and Alexei argued so strongly against this
> > signature scheme, preferring KP's scheme where the loader verified the
> > maps.  I'd be curious to hear the reason for the change of heart if
> > you can share it.  Regardless of the motivation for this change, I
> > obviously think this is a significant improvement over KP's signature
> > scheme which shipped in Linux v6.18.
> >
> > I also think it is worth mentioning the similarities to work Blaise
> > did before the most recent Hornet version:
> >
> > https://lore.kernel.org/linux-security-module/20250929213520.1821223-1-=
bboscaccy@linux.microsoft.com/
> >
> > While Blaise's patchset added to the UAPI, that was done simply to
> > retain compatibility with KP's signature scheme; your patchset does
> > without any UAPI additions, but loses compatibility with existing
> > signed lskels.  Beyond that, the basic signature scheme between
> > Blaise's patchset and what you are proposing appears the same ...
> > which is a good thing as far as I'm concerned.
>
> For the rework, I've mainly been looking at KP's most recent series as
> well as some of the past discussions. Mainly trying to see if we can get
> away with a simpler model and without having to pull in BTF support for
> the signed loader just for the extra kfunc. Over the last couple of weeks=
,
> I've also build user space tooling on my side to experiment with some
> real world application which the signed loader would have to deal with.

Out of curiosity, have you discussed these changes with Alexei and/or
KP?  You surely know the history here, and as I mentioned above,
you're basically proposing the same signature scheme that Blaise
proposed last September and we all know how Alexei and KP reacted.  I
believe that Blaise's signature scheme, which you've adopted, is the
better option so I'm happy to see you move forward with this patchset.
However, I don't want to see you spend a lot of time on this if Alexei
and KP are going to react with the same attacks as last September.

> For sending a v2, I'll have to move this slightly deeper into verifier
> side but before the main verifier work happens in order to solve the
> exclusive map race issue, and additionally we could also utilize the
> verifier log to tell the user that the signature validation failed.
>
> I think a couple of things would still stand out imo: i) we sign over the
> raw bytes, not the derived hash anymore, so the hashing is only used in t=
he
> context to tie the map to the loader prog, but not anymore for the signat=
ure.

The important part is that the PKCS7 signature covers both the loader
and the maps and it is verified in the native kernel code without
relying on any actions in the loader.

> ii) its one single scheme and not a parallel branch, so the main loader i=
s
> built upon the updated signing scheme rather than having this as an optio=
n
> on the side; iow this replaces the in-loader check and there's a single P=
KCS#7-
> over-bytes path, not an 'if (signature_maps_size)' fork

I think if you look back at Blaise's early efforts you will see that
we've always favored a single signature scheme.  Blaise's various
patchsets only shifted to parallel/compatible mechanisms when it
became clear that Alexei had no interest in anything other than KP's
signature scheme.  We didn't want to remove KP's signature scheme
because we believed that would be a non-starter for any patchset; this
is one of the reasons why I'm so surprised to see KP's signature
scheme completely removed in your patchset.

I'm happy to see someone in BPF land come around to supporting
Blaise's signature scheme, I only wish it happened a little sooner, we
likely could have saved everyone a lot of time and stress.

> iii) given we
> expose the verification result in the BPF prog, we also don't need a new =
LSM
> hook and can just piggy back on the existing security_bpf_prog() which al=
so
> has the possibility to still reject late at this point.

If you look at Blaise's patchset from last September (the one I linked
in my previous email) you will notice he didn't add any additional
hooks either.

--=20
paul-moore.com
