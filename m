Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA0938F241
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770191917; cv=pass; b=cnJSwQxo8BKN3EQi6897B5Yr9o9XBsmVxLcn5NgwfxbJhlwN2LmHpTcKojqKcQid9CKG4Zm0cKnUKJdZnxFkSGPmFIU2qvIvhw32gK+VXCqtNwFziOXDBrH2CIUGaoe/kNzfsXnpdV/nT+e1eot/j5BFuJoBtz6hDVZUbPmux4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770191917; c=relaxed/simple;
	bh=7PD2ebfj/pl4/monO6Ko1cl4ogxJpIFc3JvtRWit9lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFYsnE1+o/AreN3P52VaXrm78oVmi6LGwi2YcWqY2QLIpdozGCWwUUptwp3aD5CsgG4dTfp8M36L9/Hv3ADMQ0CDDrVoPxdcu4dna5TF4QHHaY81VLJw+HBmjGHq2G7r9oBmDl+ubvx5s8LyoVZoKShTz61sD8S8BKRiUH7TVe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BUobRJSn; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BUobRJSn"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-124a1b4dd40so1876875c88.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 23:58:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770191917; cv=none;
        d=google.com; s=arc-20240605;
        b=NIDsmXRp6wGCxF1UiIpP1zGXnCTz48/Wf1n/lsOZk2grfMFpu1KkwdG7AT6QeQ7wIb
         LIWdUNrW9ovwcAI3O0T32K8wBKzFfFNk6dDTrgX9xFZBFdnWzKSFB44yjQ1NXYI4TBTy
         DMEMSwg3zUgpH3Pz8xhr5+boSLXkiZs8+o1l4J+vku58s/iQb47eHTrtUNBqEZ6q6jch
         udGMjuYfphDdp3UaNgLYJ85FMLbdmKvWbhXTcXRnIUbV4B5oYqRtHnt9uJrHFdjjRkjT
         GPEWs4NmgZ0cpJHSP+ZnPOLXg3j/b/0ycQeCfYXcsaz1Ue9K2ldYU6yG1ElWxdlC+CX4
         3XVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=56aehhe+EuiZHUtdEUR7+weTIsrC59CA2iqo62pBWpo=;
        fh=ryWLZeDsSnFNYjbtpf09rpOu8q6fe4Nrjz+Jbg6fcOA=;
        b=k8P3Ej48ihLfYCQSYQFS3vlQT6kAxzJRNhpoBt9oaydWccm5rPQO0XYhLIbNFsO3L+
         3pNNMAFQpL16jcjm2j1th2qUo7YwmxnCZJQIFLGWveRBFwt6d736enzCeBoicepNSBNv
         a3SV5nrAlCm2Ato232W+fLMgNfvTcNuJp6q2jgtnLfsDVKaw79XuT8DyibO8lI1HMbel
         w3WtbmSI7Q3ECFaKEoSC+ywT02fogqS/r12nR27KvW2MNRqZBGoFsGrpjxBH9ThsbHVa
         4JSwrjHhlH5wXPjSL2FnsfQ2CB5aIoCOMJZ+7VAS2OKj4kZTj2fn7k1jltbUQ3kHauF9
         EKjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770191917; x=1770796717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56aehhe+EuiZHUtdEUR7+weTIsrC59CA2iqo62pBWpo=;
        b=BUobRJSnumH9LH2y6mwqLOWKucJPN5akUrT69zU3lu222qYI+2wZZDV6gJw77WUD1t
         hm0oeSSOj7uoLaKlaxlB5iUUTdLPQBvOVArHcDDL6y4AkaIcWeUqhFR2SXpZSYOnp1k5
         qaMV92jJk4a5bkhJVquw6pnEZFDc4nQxZYXHxBXJ4JD3rxbyTxvA5w2wcrPgzwl0BJps
         JYsT+VR8JJCwFsn+YIakcVionYfuJVVjMbwvHct21W+qi6X7raxvAqAiVOIf7yl7MoV/
         qngWCz0s7+SJAEhAYrQTU9gIvchCYSbAa8h7Je8Fjglk8MDf52JNhMiWYfKtyBLa+Ii6
         2IhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770191917; x=1770796717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=56aehhe+EuiZHUtdEUR7+weTIsrC59CA2iqo62pBWpo=;
        b=OMqmiHf079x48MLK8bG42QWPll/ifgqXHPpifG6KQuI849ZxSj7ZPZW7JB72Z8H4rf
         elGvH4f+DcvgHHogx/t5gqBgFM5HO1pm9m6mX+vHAp5ZleWkUMWmWqYAOn2u+LI/EMCR
         TWT5CB4YZrXOtTQt7SueaoaRPsDJBehFGOTYwGuO+iAuKp25C7pU/TYeI/HUjiwmf2iG
         KMshKI123c0lJvH0PCUTi42+EYFHml3uDus686YAW+j70EMGPzuj77Mxg1AH+QyKjO8J
         Q9Na9Q2Ztgz4bh+/hGHsBW9AUrh0P8Oy3XDpy5+cTp0k3tOnkbxlVDPgEcCrRHI7AzxL
         FaTA==
X-Forwarded-Encrypted: i=1; AJvYcCUAx5WWFAV6uauQpVVIspfLdI4UNElyRFLH8lx9oX5VrI6b3paDOr+5+GFkuoAJvx1/Unw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSPdpxTShdW4SY3zXQkPISLwM4gcqO7nEPUd34ZFlV8OZZfLsu
	AUjWlp2DIgq3EpwvgcSplin5KcBe2BEvT0vLe78x9R/lqzzisMcT7vjjpcJ5WRcm4rcUCLX0LRN
	f3JjAWYfcinJxvbXwZT/jF0kbEHnoQ1y7rMvPbObY
X-Gm-Gg: AZuq6aJhYRnm4YWwuFY3I37QXNtkH09KNawJwoWK0tKHXB9TZ9WK3Rw8xKG4W0wqNGL
	Qc//3FrzoaEv2VtRbW8Gux5lL3LdgXGy9Xk3AT3nerURdf1GSPA10L/D0qxBzOCo0c4SV2fMijd
	b//KiR9rvre1hw9BQOHIdmJOtVwzXtQiS9ZI+W9sc9f808zsKkHFH4kChkkHndkAquYZnxY4LRA
	Lgw3sp2N1a7k9g66CFagAB1uWsGFwbdzPCGbk+XqnFrwVRCP4uQkWq8R2TJ3kdSbJ+AHlvLUmN0
	oe92sVOy82VpcT9pM2KImD7kGbPVQUKArlF3uSHRmfZ4tbe/1ZKo3+7QuA52
X-Received: by 2002:a05:7022:2496:b0:11b:2de8:6271 with SMTP id
 a92af1059eb24-126f47cfc0cmr978187c88.39.1770191916262; Tue, 03 Feb 2026
 23:58:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8d055903-fe44-4bbf-a1a5-e0176343bf0b@rbox.co> <20260203200242.404131-1-kuniyu@google.com>
 <80865b12-7786-4787-81c8-08b754716a5d@linux.dev>
In-Reply-To: <80865b12-7786-4787-81c8-08b754716a5d@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Feb 2026 23:58:24 -0800
X-Gm-Features: AZwV_QhLODnmt_mJ-te5vlOzU-7R3Ad38OYPgt109s7gbd2Gj9Toa0ioFZVUzUk
Message-ID: <CAAVpQUCshzAAHZQQ7sVE+3UdKmBV42bKudcdDR0KtaTcTqn5gA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto update
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: mhal@rbox.co, bpf@vger.kernel.org, daniel@iogearbox.net, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 11:15=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/3/26 11:47 AM, Kuniyuki Iwashima wrote:
> > From: Michal Luczaj <mhal@rbox.co>
> > Date: Tue, 3 Feb 2026 10:57:46 +0100
> >> On 2/3/26 04:53, Martin KaFai Lau wrote:
> >>> On 2/2/26 7:10 AM, Michal Luczaj wrote:
> >>>> In related news, looks like bpf_iter_unix_seq_show() is missing
> >>>> unix_state_lock(): lock_sock_fast() won't stop unix_release_sock(). =
E.g.
> >>>> bpf iterator can grab unix_sock::peer as it is being released.
> >>>
> >>> If the concern is the bpf iterator prog may use a released unix_peer(=
sk)
> >>> pointer, it should be fine. The unix_peer(sk) pointer is not a truste=
d
> >>> pointer to the bpf prog, so nothing bad will happen other than
> >>> potentially reading incorrect values.
> >>
> >> But if the prog passes a released peer pointer to a bpf helper:
> >>
> >> BUG: KASAN: slab-use-after-free in bpf_skc_to_unix_sock+0x95/0xb0
> >> Read of size 1 at addr ffff888110654c92 by task test_progs/1936
>
> hmm... bpf_skc_to_unix_sock is exposed to tracing. bpf_iter is a tracing
> bpf prog.
>
> >
> > Can you cook a patch for this ? probably like below
>
> This can help the bpf_iter but not the other tracing prog such as fentry.

Oh well ... then bpf_skc_to_unix_sock() can be used even
with SEQ_START_TOKEN at fentry of bpf_iter_unix_seq_show() ??

How about adding notrace to all af_unix bpf iterator functions ?

The procfs iterator holds a spinlock of the hashtable from
->start/next() to ->stop() to prevent the race with unix_release_sock().

I think other (non-iterator) functions cannot do such racy
access with tracing prog.



>
> >
> > ---8<---
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 02ebad6afac7..9c7e9fbde362 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -3740,8 +3740,9 @@ static int bpf_iter_unix_seq_show(struct seq_file=
 *seq, void *v)
> >               return 0;
> >
> >       slow =3D lock_sock_fast(sk);
> > +     unix_state_lock(sk);
> >
> > -     if (unlikely(sk_unhashed(sk))) {
> > +     if (unlikely(sock_flag(other, SOCK_DEAD))) {
> >               ret =3D SEQ_SKIP;
> >               goto unlock;
> >       }
> > @@ -3751,6 +3752,7 @@ static int bpf_iter_unix_seq_show(struct seq_file=
 *seq, void *v)
> >       prog =3D bpf_iter_get_info(&meta, false);
> >       ret =3D unix_prog_seq_show(prog, &meta, v, uid);
> >   unlock:
> > +     unix_staet_unlock(sk);
> >       unlock_sock_fast(sk, slow);
> >       return ret;
> >   }
> > ---8<---
> >
> > Thanks!
>
