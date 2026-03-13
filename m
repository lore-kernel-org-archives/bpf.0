Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B665A35BDA8
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773417401; cv=pass; b=YIT5ZylgtorbFk36dgYzfLSLX4YzUmqxBddvDefCHzvwOlt6a3qK7xcAffdgVKi8HYAuPzR+GBO3d9NMHPInu+FUaprDKzcKpuh7wJHzp6yxFHq2SCN/O/EApE2oG2GZtBXSWyjqPwI5gfPs9BiSkIdZKRs7+O1hONBUmLJF1U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773417401; c=relaxed/simple;
	bh=U4FXZqGedoQo6GHPwQEh4xyFD0HQuCVujMQty+kI5sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpVI42hO87f27sLc1qEED0Hdr/doLIV+TAUO6ilBUI5Ql/S3tGxkjKnTIGuriJtGip3Lcnc/4w4G7hyvCugbl2atTvbIyI4at9DHXZoSXBe0TBRn/Ct2MUyX3FekXlAbFKCqc+dabMqTpYPjL70aQMGg520V0iNTy0absrMT3SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=prh3beB8; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="prh3beB8"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-829781b2b01so1561373b3a.2
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 08:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773417399; cv=none;
        d=google.com; s=arc-20240605;
        b=Z4NPzQOa2oRpJBmhYwpvyh23Vf/S5KKNI3RzpwhUnTFVyZ18/Yet9YG46KRGWdL6ID
         +9bJsDRnagdPO/ySLxn3O4RRqh4RNyz6oWzJ0HhhyuADLPWVz34Jg8lY5rNbH/Kf/HIz
         +ZWcDJIS7HH2xmd1TSFnPDp/whiNi4p0Z49LchXavvdCOmuwgWojArr0HNDUmjPPPQdS
         0Y3CxAbGOM9DtqXWIBE05Oxh70dILGa2xjNs8C2BWay/xAq6r3W4oenhLU4+gxIMbwF7
         H4/qnoI/2o/jTDkbnmq+ufYGzUaGYf64qRKzosT4wIqpgL0iGVxmPzuU6P0pJ0oNeHEa
         5KIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nsUa3+3B6RN4LCDLMBVKPL0aCncmwB7rIzU/94GsesA=;
        fh=Meoox2SUybSMarQEjGruelNljALJ+rv1dH2hJiUWweU=;
        b=NsJrb1xi588CBlzjnUegYIUwHqtydLVToJlPQxMY6ykBxfRmVtRm2l1ntk/XzIAxsW
         bPvv4c04F+UScF8HLS20ysgi/s0HarLiw5FWii0u6xFcRT0r4jg2OzRx1cK4pCFkuMIq
         ZooyIIGE9AsuQIKCb3CvxzNsUpZ53Ra+uC+4xnlOmuYh4uuswdMXR0QS+xQZDfK//PJ+
         dZe2vf5bw4SkMZtiJMYrgY0dHPnY478I5FPMAXKavNbhhj9emg8QOirU+jTVpiUTmlOy
         Je6M2vEM5cj9BmxsPU+DIr80XefJT9s3YVxbvneFGT9+5gVyqoIL5XpGprXKWDAw8kEB
         uRwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773417399; x=1774022199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsUa3+3B6RN4LCDLMBVKPL0aCncmwB7rIzU/94GsesA=;
        b=prh3beB8/xEYRcUtT1w+blslPXzk1ky6aSg86RmuyQwYzVBxsUjcuOxPSh6TbxDBRL
         ZdT/RfRiaHHxsoP2Xyw4JPzkhJELWsiTHAY+Z2x1R3EXzS7tm+Em//LusCeuqthDzc6D
         W5sRRM+91FNVNAm20UyHN4cIQ4dBHsTesLlQgOEsn7DWsQGAWvXWQEzGUKMklM5eLjTD
         u9B9oZxXTFYUICV8UH0o6k4a63vyA6MyJM8X7t4Ouv8bot+yPupuw9gCOpunC2XxxGd1
         kLvSouH8TacmErFJOJQPSYo1+g3kB5SFeMnd5/XrWgmxopJ8wqgKBsus0awirTzZZ4K/
         pLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773417399; x=1774022199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nsUa3+3B6RN4LCDLMBVKPL0aCncmwB7rIzU/94GsesA=;
        b=e7z2ZFMP2uXS7SkOlNSYlJjyT0suFn95+mAglkpvnZ5bi/VgCFTy3XWP+2rTS1BLZP
         sJdVUWXSJR9jFbbf2mDsnPjmyIGMyWGgGxAf+7bqdT3geEVA5APzJIfRLcKYWZIfFQHR
         6atRfAKqk5orsTpZxhvxSMipXU0hkl+Gso1dSYp4A73UH4AqICTjlsBGldyRsK0whZ2h
         rnWHUBKMbqedbBmlfy2jfplDnJFLf8BxbkvDCNuzc7EmNzIO5HT/ofpm2rnbXbsuJ+Xo
         fGk0exegkkM5V8XZwmscT1pDJPKYGsgeKcH8BhooWAkM45x0iaebxAniBMRvdtJZihIQ
         5cLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYpK1e9m1sreWBMFewa/iDTEtxEX/ImxdtNoxAKsVzJuFizzDkuj5sbHwFTuvNfFYMn1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPQh5pbIcgGZrZdc9u3t0RubB9VyLzO/WEaCg4nHZo5AZvZXbp
	UsPS/QUpPXKbH7ZQjQ0obDwoULjp9ArtA9yEYA+UIh2zcPFhkFXn2mwY9oQfoVsoT+q5YN8ywIu
	ga8SsUmbVXE16kiMuqPEKiuf46JNnhDHVtT2KHvO3
X-Gm-Gg: ATEYQzyeP/mpl2YnSEwx3+UA9HmDLL4LvJ516gTnIJYDi5ndDG7HK2E+t8vn8wrvDXd
	zxyv7dAny/Lu9cvQZm9BkBmpMHTRaRZvl7EPGJoGioYy70XCMvazf/DtmIrvrkZjxlN4Jip4c+V
	synsO6aIzjd/lhNmTzaO/fxcrTLUn2X2KEBNcYa1Yeu1u9bwvT25G+eARIX6qc1sQ5hMvO6NHzy
	KGM/n3GNpMlQO38KJRR6RNqjyZHqps2be1AGPKWeF21/0/Fdx87KCho1Lj+yG76laFkklymLxqh
	BGQnNH/YF/NSCc8=
X-Received: by 2002:a05:6a00:7598:b0:827:28ba:ff00 with SMTP id
 d2e1a72fcca58-82a19711a89mr2559770b3a.18.1773417398762; Fri, 13 Mar 2026
 08:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307212058.169511-1-jhs@mojatatu.com> <20260310184713.7e810431@kernel.org>
 <CAM0EoM=TAAfwZc3q1=RKWPrS778R_B8uM18ev_jYYz8oj4YiBA@mail.gmail.com>
 <20260311175249.54abe1b6@kernel.org> <CAM0EoMnv14pSaJWW3ZQuegkbQEqqye0zp0-_tCaOEWEg=C3xCQ@mail.gmail.com>
 <20260312165113.773a5f44@kernel.org>
In-Reply-To: <20260312165113.773a5f44@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 13 Mar 2026 11:56:26 -0400
X-Gm-Features: AaiRm50MOGl4w3-L4BgOwap80DymsQR40mcNnEN5B2Df3vQGH6sofP4bOPy4H1Y
Message-ID: <CAM0EoMm0dMRKJyfCH80G=q4PnnTzzKVRvSrAU204FFKMn9NOtQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Mark qdisc for deletion if graft cannot delete
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, toke@toke.dk, 
	vinicius.gomes@intel.com, stephen@networkplumber.org, vladbu@nvidia.com, 
	cake@lists.bufferbloat.net, bpf@vger.kernel.org, ghandatmanas@gmail.com, 
	km.kim1503@gmail.com, security@kernel.org, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 7:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 12 Mar 2026 16:36:48 -0400 Jamal Hadi Salim wrote:
> > > > Two of the several (I think 4!) patches we had took a similar path.=
 I
> > > > am trying to remember at least one variant was bad for performance =
and
> > > > the other was unstable. Let's see if we can revive it and take a
> > > > closer look. BTW - none were pretty, it was maybe half the lines of
> > > > code but touched many things.
> > >
> > > FWIW / of course, we have to apply similar change to all(?) callers o=
f
> > > __tcf_qdisc_find in cls_api. So LOC-wise it may end up also pretty lo=
ng.
> > > And it's not going to help the already spaghetti-looking locking. But
> > > even if it's more LoC I quite like the idea of containing the poopy
> > > code to where problems originate which is the lockless filter handlin=
g.
> > > Fingers crossed..
> >
> > Something like attached.
> > Unfortunately after running it for a few hours it reproduced.
> > The action code path (entered by virtue of filter code path execution)
> > releases the rtnl when attempting to load an action module. A parallel
> > qdisc operation waiting for the lock then grabs it and we hit the same
> > issue...
> >
> > So now we have to be more invasive and start coordinating the action
> > code etc, which is not appealing. Thoughts?
>
> I see. Doesn't seem entirely crazy to let tcf_proto_lookup_ops()
> return -EAGAIN without actually loading the module, and have it's
> call path (of which there are only 2?) do the module loading once
> all the locks are released. The call paths handle the EAGAIN and
> retry already they just assume tcf_proto_lookup_ops() has loaded
> the module so they don't have to.

I might not be entirely following what you are saying. The core issue
is not module loading perse. We can avoid module loading in
tcf_proto_lookup_ops while the rtnl lock is released and the qdisc
refcnt is greater than 1 (which is what the patch i sent attempted).
The new quark is when we have actions associated with the filter.

I will send you a much lengthier description of the issue in an hour
or two  to get us on the same page.

cheers,
jamal
