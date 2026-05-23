Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49932D5940
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779556789; cv=pass; b=J74cJzjfWMeaf6Cj+c3dinqEfEBZAYBq3vzJwDPniRQIjx6tKIpO3wp9aI5H8EtN7YdsdEa6/pI2UrkeYsP7qGQ6VpR+Qv0hPCMXEgE/RiDJ0xyWHx/AsaTGeOrkBmyWyiCKYDoXOkpRO1JKojxGhXLLG+RN5ot45+EtanslsO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779556789; c=relaxed/simple;
	bh=K1T3+eD9aA+OMvgd6PqU3zP6/5UBn+pjCxI+BISD4p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GkNTon4RMSAhGw5qNk9xg0dmqDIBpw0/h/CJHKTsaRB7+p6xBtopn146TCaDH50chdzbF+1YZLs9JCxTwleLjHI3xZOQVzIkh/GaW6hVDajqSGNd06rRftkDNvhRRkNGPuAEBXL1ktXHwrPnT6LaohcDINbjb1mHJwCVkDnlBdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmapnEgW; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmapnEgW"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso52138785e9.1
        for <bpf@vger.kernel.org>; Sat, 23 May 2026 10:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779556786; cv=none;
        d=google.com; s=arc-20240605;
        b=DH0YP3emreE0wWtIV0iz9C/pjjL04ArgpyIbLekfERR1IRlgnUbSK3S61KA1zpPZEd
         cjF4b9FqVot/qNHUsF6xbZF8PFsFp3AGntwgypGWkFtjrXg9O4J6Kdkoopjstr5nw5cr
         qdooBQv4qOlrLaKt7fmthMJr9DOU/e2p7Fnx722T2NOFnPeS7WmT7OFQeuovxQT5iLLe
         XSD3ZIFlH1s6UufCs/1qqZZzWNvaIRujNxwxN07PySdU28VRv2Vqfe2b5CjsRdTojXEO
         9WCOx5QIkIgRfj5Xiyf37xuF0YAdjpPkDrCqJoZ9w8e/jdsq2Yi9rAvnzWxPaGjicl+O
         GlbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=40aScu3o7jyER+7kTPK+D6ptkCZ+Wk4tkciyEzTWbok=;
        fh=n+CFhUxPc2M2/wbvXX8s5niLFzTAK2LP9rvtwhlHEkQ=;
        b=RMQMhJNE/oATKgwTTLKMeqHsGd+h5gnr3ebIjTUFj3u9dZD5AHVTjJNb1A5YvQL36p
         H3QsPYF9WRYbDfKEMkIyEfB3vYfM46Ml9kKXWx31Zw3bkfcvidQVbR4atF9NS0R99T0r
         HW80b/yYzynydjB5y5NyXeCkLPB+HTnHKMVxI5SmsGAfvvp6Qo2DPbJVFZPN49/b6SAg
         I8Hl/Cd5fI19wGR7utQIPVxV6cZB2iydYHU4hEHDavMi7NUj5RvQynJJg5tVC43pxFKv
         t4trIUZmZKCZm0BAglhm/7rmEm21s8lsimLPC/T9fCjlTdZP7Ky1g/+nyS59pixEB7Ei
         PKUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779556786; x=1780161586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40aScu3o7jyER+7kTPK+D6ptkCZ+Wk4tkciyEzTWbok=;
        b=FmapnEgW+t/qXrYFlRR6CiNQho+6JdY6zHiIJrj3z7Cju0g8xBj5aNzg5+2vEf5wam
         1qJE8GTahqWyTU/ceWXDMvVwFhVkWCWY8oPZSWncDZyVEB6ksJEe1ib5Ve+6opinoF7R
         SzAXJQpK6I65dRJSDwSu0OWwu8Ig+XNFMrdJede940h0EMJAKffgDmFImIK6Uj1eerGE
         0grBvsEwdrJBIi3F6LYNp38n0D3AeGdlw/oLx57p0xsmH7qC9zKZaGYzffmacqgkmhhw
         wcDvbvvAMZ0hzAchzGrpHtj3q/nH6a1Dv+W4BaUi+9JOgpmkgwLFPatgxAFvHj+29swH
         Dv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779556786; x=1780161586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=40aScu3o7jyER+7kTPK+D6ptkCZ+Wk4tkciyEzTWbok=;
        b=YgEgaOdta5dL6TohBSHLFYmEMjyATppILaEC1rWAkD4sBz9/bApvbmLn9ZY8IQkdti
         MeP2pPAq/ppckKznb47MV+nswONpSS0JL+vRVkVjXPuk8ficvZcfQXN+Vp8GXyOLCUDX
         MQtPvsIv29OcM/RSjG+nNRyzLXskqxLMqLjNJjz5MZ9PX67H2s0RngBmNVYwIUM2e2xG
         V7b1jCXFGlXRh8VhGoRUmlb64W0EUNgjaZik+ZWgmJeo2ZNsioW+T6A3szx0FagGc9n5
         DANcdObJsi4XvU4361kZHCcbIGle5LS7uWOv52TdF99XZYcMWcMUiOmtEmXPlQ1vylVB
         w1NQ==
X-Gm-Message-State: AOJu0YyRCOF2fUgD9zUxYzXa/y9HLKd5H3tsWCBGQmz/oK4SQIk4irEg
	rDhKoLqHG10RINZjxWo5U3PiSFE+jsExA6BdZnmCuJWLZFS6AmCAVnSRJ0ycBNEEdtt/21S9l6V
	bq/xQUta4UhbzLT30ImPOWHlziS1LjUw=
X-Gm-Gg: Acq92OHsGP/N9Ii/i4qcExyEaSdv3t44ETDi5gKUjx+t20nqVhB4jPSQzX6QGDMjYtC
	6G3eU9P6wZ4WoefT4yrW8Q0YQ5H27GGCsGnAmYB+8MITUjkti8f/BmguyQjpc7uu3pZ6vHByDxz
	8zXIpx5MhW+80i6lNk525RPvLwfaqp3FSeHjwgQk17jduZkrzvcpGoZN3EZs7Wj0bRp/+qqKJRh
	TiLWzXAFIjDXoDgCC0IUmbQZ+pMCNm0YUQT3dAqKLW2OldQdJ5Sapm+wrlG4pfcPreFbyR5q+Bj
	SvNecKrw9WzyHGw+/3RUSwFs4Ob5CL7NlW52qcWeUzzRb+Y+1C5cKc4ukBWwvg79Ie1hqkHbw7z
	AWr0=
X-Received: by 2002:a05:600c:6287:b0:48f:eb8b:997a with SMTP id
 5b1f17b1804b1-49042ae285bmr129991135e9.31.1779556786114; Sat, 23 May 2026
 10:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523160025.16363-2-paul@paul-moore.com> <CAHC9VhR6RSq1TUgAyvHmaF01h87Cazy=BNJhk654BP8yfeSwng@mail.gmail.com>
 <CAADnVQ+WTfgO636GqgxzJ6r=jENpG704kmNAsy-X8=WyjMOV+g@mail.gmail.com> <19e55c1c1f0.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <19e55c1c1f0.2843.85c95baa4474aabc7814e68940a78392@paul-moore.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 May 2026 19:19:35 +0200
X-Gm-Features: AVHnY4K_2LOQGo6EDOyrLqN2RlxJguE4BGreszcdQyAdCmg4grCbohDxA-2rs98
Message-ID: <CAADnVQ+JDtc_GdxCv6tWAT03k85PTc0+zdcpCQ6NU-T8yJcu0A@mail.gmail.com>
Subject: Re: [PATCH] lsm,bpf: fix security_bpf_prog_load() error handling
To: Paul Moore <paul@paul-moore.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 23, 2026 at 6:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On May 23, 2026 11:25:55 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Sat, May 23, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >> On Sat, May 23, 2026 at 12:00=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> >>>
> >>> If security_bpf_prog_load() fails there is no need to call into
> >>> security_bpf_prog_free() as the LSM will handle the cleanup of any pa=
rtial
> >>> LSM state before returning to the caller with an error.  Thankfully t=
his
> >>> isn't an issue with any of the existing code as the LSMs which curren=
tly
> >>> provide BPF hook callback implementations don't allocate any internal
> >>> state, but this is something we want to fix for potential future user=
s.
> >>>
> >>> Cc: bpf@vger.kernel.org
> >>> Cc: linux-security-module@vger.kernel.org
> >>> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >>> ---
> >>> kernel/bpf/syscall.c | 4 +---
> >>> 1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> Alexei, I'm assuming you would prefer to take this via the BPF tree?
> >
> > Paul, I see that you're intentionally trying to piss me off.
> > It's not going to work :)
>
> I promise you that is not the case. I was looking at the sashiko results =
of
> the latest Hornet patch and it identified this potential issue in the err=
or
> handling code that is an issue independent of Hornet. I posted the quick
> little patch above to fix the issue, and since the diffstat is solely in
> kernel/bpf/syscall.c I figured you would want to merge it via the BPF tre=
e;
> if that is not the case let me know.

It's in a queue. You can monitor it here:
https://patchwork.kernel.org/project/netdevbpf/list/?series=3D&submitter=3D=
&state=3D&q=3D&archive=3D&delegate=3D121173

But please be advised that when submitters ignore issues
found by bots and maintainers agree with bot findings
we mark patches as changes requested.
