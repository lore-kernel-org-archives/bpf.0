Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9D937C927
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 21:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787089111; cv=none; b=Zh059oBxTtY1OabC6TeymE42u2Yh7d9NKeRdblUIX65P63o78TmnHyBXdB96FFrLMrrSdGDs9F1LVB+SzAakgh6sHRS9nkuL5z54snJ4mT7mJnIzns3ksJOBO4fFSOt9lVZx8uwnooM6fsQoeru7teQMO4+rdQYqKm4wXIi8ly0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787089111; c=relaxed/simple;
	bh=GPinSQFO4keSd1Q5bC5YTK7Ezticd5+rWlEfu42Fe/E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pGNlRknPOo06jc9KagOVW7+IqPcS7TIMTxhDBcp4vpwk6m/SZRm66DBdeo0xlNNug8Q62kH3QhkBoZx3vLcYm/ZaIW0SR+z1+39s1DOTd6cHWWhAQDEWuVxEx5tGL3twkn7J+5+Heoy8W9Z+ZdI5oJdbxGsj2+KIkj2KpuZ27pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHqH2vfI; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHqH2vfI"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so592945a91.0
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787089109; x=1787693909; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5pr8D9dTko0nm5cpxv7gLu3MP5nFNJnzsxpSKuqHUmo=;
        b=DHqH2vfI3CokoJHsnQ2zLyJc+J9LVADwT0fEANQxoIF4V2+R9fY24HG1QvTqD+SQv7
         7yrs7/cpYTV1RcV4ORupXm5oq9+NODSsrstcGeuy86MrjBkEPKZ1xGE9jKAy6KjBumvn
         j16Nl3Rlhd+27KFWoatYUulQNQJD9rymfk0cEOfHU0WVsBwKNa2PMwNmdD1P8KL+rJEP
         cy+qr7AXdFf3/rOG4o7KExAMBatknXXDPNlUKEtQOPIoAvv/7v7RyKSNtZE598C2F2x3
         OYH9XlgZR3Gc/YKfEdzZQ9E1RwuH+wog28obhfP2MGek1YtAAdXYlwnPZex6xd6HcUWr
         Ep6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787089109; x=1787693909;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5pr8D9dTko0nm5cpxv7gLu3MP5nFNJnzsxpSKuqHUmo=;
        b=UrvEj3kLYSTeK2FP4Xgfo+4lYcpZhOxOTqZM4rHXdFFEvlOU2T+A/XCLVZ/TANBh+9
         I84NH4K00LsELHnqhSEm7RFPMVjBXit/oH0gIjduvBvYxS3rlWRnb+GCYs2Cbkii5j0r
         iH2G+1QDiMAOq18XV78C35vN2+bK4gvayWAzSKiZES8KCBFDb0c69LD8KnUUlGGO5Xs2
         BUmOQNNj7DDOf0X8NeJznaODOeHsaHskggsxZmWEImS509cJQWjdMvQa0jgbvTp51mUA
         45mzDa6Quelt2L/dOeX5WtVh3h7ji3l1m7m4O69sZ8UrB7rp/Tq9l0QYYuj/4wUG+8Xh
         jIzw==
X-Forwarded-Encrypted: i=1; AHgh+Rplx+LL0p9+DBlkat0Tdp/BlZ/N5Njxsag9dN3ZDnh2A7o672KdztpBZirC7dKlh8YllhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wkftwhdTGzlJFdrNzmlSIoB9F8smUol8qEyotKnXEi1mfSIx
	cW6zodbSuqzOEpHfUOk5VKOSVdGFGKd90iZOm28jWweJ+f0P7sM3yJsd0m2BuTL6UIk=
X-Gm-Gg: AR+sD134cW8yPud+DUPQ963FLJtO75hsA//HMCZVx83eegguZK202iZa63kopDtHsha
	TZHme+fADFL+8DHwapxOIlOoluqQkQNb1bkR0OCtpb5nuIEA+GQMlM5UQtbR5CxUw9lNsSCF9MX
	WT5z1IZv4HCRg7Yn1odbhJKev1L4oHUpxNy5PlWpLOocGxHB7ls5WO8eoJ4bnRG9SyPAl2PY3Kv
	m173H3WeAaydPAD81x5A4n2fScHr8te9jdU/XDr9FT3NGOv1eB0DtWi7tJUTjTMPIUprbe0uPo+
	lxxJTvAv/ebV4V4NFeMXCAEt0jIpY4ktzFQ9B3ZJ/60iMtMK0kSEnGOb+6GDi59Kf+RZ+kMYX/e
	We59VcOiXYDYbb4ju3BE2fOtaiksvTRgtAgwwUjY09W3jgi940HgOw2xs0mUiIgOlAIkDL8niif
	xbLbIVIyXecs+i3HVByo6eWxTfjjgl5dqfH7jt+g4HEq+ITjrxEvLQkWHFoHATb+VgxiGsukeaP
	vOpYs6jSPnUBe9wnH+Q0yV9U5M=
X-Received: by 2002:a17:90b:54c5:b0:38e:6aa7:68ad with SMTP id 98e67ed59e1d1-3957b1c5cc4mr1267082a91.5.1787089109181;
        Tue, 18 Aug 2026 14:38:29 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fbba811sm122046a91.13.2026.08.18.14.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 14:38:28 -0700 (PDT)
Message-ID: <17813f00c2c81cd2588672197cc6d4de619ca36b.camel@gmail.com>
Subject: Re: [RFC bpf-next 1/6] bpf: turn bpf_reg_state->precise into a
 flags field [NFC]
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, ast@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org, memxor@gmail.com
Cc: martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	john.fastabend@gmail.com, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Tue, 18 Aug 2026 14:38:25 -0700
In-Reply-To: <20260814231945.3884596-2-vineet.gupta@linux.dev>
References: <20260814231945.3884596-1-vineet.gupta@linux.dev>
	 <20260814231945.3884596-2-vineet.gupta@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 16:19 -0700, Vineet Gupta wrote:
> bpf_reg_state carries a single bool, ->precise. Other per-register boolea=
n
> properties exist (and more are coming), so convert the bool into a u8,
> call it flags and give the property a name.
>=20
> =C2=A0 -	bool precise;
> =C2=A0 +#define BPF_FLAG_PRECISE	(1U << 7)
> =C2=A0 +	u8 flags;
>=20
> Both occupy 1 byte at the same offset, so the struct layout is unchanged.
> ->precise was the last field, after ->frameno, and ->flags takes exactly
> that slot, so the memcmp()/offsetof() based comparisons are unaffected:
> every one of them stops at offsetof(id), offsetof(var_off) or
> offsetof(frameno), i.e. at or before the field either way.
>=20
> That tail position is not an accident -- it is where fields live that are
> compared semantically rather than byte-wise. ->precise is never memcmp()e=
d;
> regsafe() tests it explicitly, and an imprecise old scalar is a wildcard:
>=20
> 	if (!reg_is_precise(rold) && exact =3D=3D NOT_EXACT)
> 		return true;
>=20
> PRECISE also takes bit 7 rather than bit 0, because it is the odd one out
> among the flags that will share this byte: the others describe how a regi=
ster
> relates to its ->id set and are cleared as a group, while PRECISE belongs=
 to
> the register alone and must survive that clearing. Growing the rest up fr=
om
> bit 0 keeps a clear-the-link-bits mask from reaching it by construction.
>=20
> Reads go through a helper, since they are the common case and read better=
.
> Set and clear stay open-coded as the usual reg->flags |=3D / &=3D ~ bit o=
ps.
>=20
> No functional change intended.
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
> ---

Sorry for the confusion, what I intended to suggest is usage of bitfields,
instead of carving out bits from the 'id' field.
Let me read the rest of the series to see how the flags look overall,
but looking just at this patch I'd suggest bitfields.
