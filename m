Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEC754777
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049233; cv=none; b=TME6HZC621OtHsiUz5a8kuaZmkR2ATelFr8bpzPVkGySUyTiOodLJOSytCIWucg1tOj7RgZAA/KGD9sMybSNsv/UtUUWGlJ+4hQZe9zRnZyvGskTAhs1FOqWgGTaNglPhSfU+SDIQxGsQi/RNS4YA3tGqqjlGV/HuS5zNckkeEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049233; c=relaxed/simple;
	bh=0ewTtG7dY6ealROSempnii67r5uOFkBY76W0/0vyLZE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IBB9rPkCxMdI+OwX+CHStbQj76x2pzWS9XIwpctYVP8u5AKqv2Lpm/E5GYZSeM9Wxvs38SXx9DNqKSH1SuUonA3gumfWKGT31VLuW0wy9y8vyAA9UmCip0XjQ59cloqTUOpI86psuyR3B8pArExBaMGYueoxpRCX5cv8VDmPvYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSNAOB+l; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSNAOB+l"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so894610766b.1
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712049230; x=1712654030; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0ewTtG7dY6ealROSempnii67r5uOFkBY76W0/0vyLZE=;
        b=iSNAOB+l+I55UpwaU+E1r0iClIpsHV6ASL9vwTNf5zKjoz0svhZ8phKq2jmbpXAXoF
         5sAMO/bppdDQKkxhoqtSyBZrVA06QW0PjK2i3tdD1Z29M037M6511swtLAYQuTBX4wUl
         lPZIkrXLUFzT3MhW+QUpS9PiZW6NyAqGdtYTuUFHRYUtCkwpEKKpwIXh9i5X6c2prBRZ
         1Rn7ixVpEpTh/oZPSgYU1ojtLFUoK2h7tLofKtbyXRRNTuf7m2a1+MN0h8W1YBG7wz6r
         VrrXT7g6AEB0KyH7YXJLbWgKxebUPq+6chiok4jK9saF4zHougg1Odn9mWe275tUpq1l
         5K9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712049230; x=1712654030;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ewTtG7dY6ealROSempnii67r5uOFkBY76W0/0vyLZE=;
        b=rNmgXmghDqoEgB391wJ8CpkYrEIi4pJ07cLjhi2eF28oQEYvtkTRSWzwEtNb32pLGr
         +/srlE61GCUUHC7Elzl0CAmssDzY1MVXLtrvuoSrr2IARiQM0ywA5cfgyknYjwfm3wi0
         XEHK7+HT+8wrDGWOKlMZocu5KIP2Gk/oEdy4wBM/m9pKBSOxmL6Ij2MBFjyoHUNfagdZ
         1porVxa2XbnEHpWQc82kIJ4j6fZjl4ijZ2BpZpWdKoS0IEqjNqRi7pzKAmyFX1/C/c/A
         Xso9U7sI/4BKo+0svRWnM/MSkUiMp2pD8IYGMzwukxzVBlAxJj3VdnfcXVMsvY0Q5DKO
         WMrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhP25jqd7kJKeAJOfDkEGH2SXoKArvdxwOdZ0G7MIjzHkRlGn8vD3qvl71PfnfIIMbsJT9zlWdxKIYVrbiH0KAYhRo
X-Gm-Message-State: AOJu0YwOWSjeXK3+FwTj27v1XeBf5tnZkeWjnreBBoYFzWbQX4dU6/eT
	UjESebxpNlznIgHOlcli1bLdBX7lWadQLU08cOBw2vaeulN8EH+JNhK40OVuCfg=
X-Google-Smtp-Source: AGHT+IE98wiIZwxNrhlT5O90qAPHaYLUzzqwihruOtAsuUhRsu4nk5ifnueyUFdalrZhpzLEqqKIqQ==
X-Received: by 2002:a17:906:3803:b0:a47:4141:f60f with SMTP id v3-20020a170906380300b00a474141f60fmr10103283ejc.17.1712049229666;
        Tue, 02 Apr 2024 02:13:49 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906309100b00a4710e7817esm6238638ejv.135.2024.04.02.02.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 02:13:49 -0700 (PDT)
Message-ID: <0df367a5ac7a361409ea13cba606539dca6a9fb9.camel@gmail.com>
Subject: Re: [PATCH bpf-next 0/4] Add internal-only BPF per-CPU instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org,
 kernel-team@meta.com
Date: Tue, 02 Apr 2024 12:13:47 +0300
In-Reply-To: <CAEf4BzaSaWt6pLR1xj4Lv=dccr2sQhac4AC__BrR13ryb3Fymg@mail.gmail.com>
References: <20240329184740.4084786-1-andrii@kernel.org>
	 <e0426944e09d865946876f9bbd8acb7cf23d8705.camel@gmail.com>
	 <CAEf4BzaSaWt6pLR1xj4Lv=dccr2sQhac4AC__BrR13ryb3Fymg@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-01 at 15:54 -0700, Andrii Nakryiko wrote:
[...]

> > Hi Andrii,
> >=20
> > I've read through the series and it looks good
> > (modulo architecture related issues reported by CI).
>=20
> Should I add your acks in the next revision?

Sure, please do.
