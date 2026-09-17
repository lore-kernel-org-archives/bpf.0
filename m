Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E223403EF
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 00:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605403; cv=pass; b=l75AJ5mGtNw0aiJeUoWjNt2y5Qbx1FaC8J1kDFRDhw6NWwc/ULa8AoMtLXbESh4z8hbu4EZNsL8LPFpYTGRH7N8Pa0Wuecm82rdhaeucfgBcfWooyUau5gBLOY0DrD7QCXZfQPNKPY/fTGkocpi9Dk07JoCNC1l5ev73jBuT4X0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605403; c=relaxed/simple;
	bh=ePVneiu8f7HOysaEQkzPf7UPOZIwpLI2NG8wQeL1rIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVFwHKs4IIquz73A4AZE3EV577PG2j5qZ9p/E/ICZiKmiwCVOAkWYDyNaeLsaqd9EIYQKW3N5hMugQFFQor6hu/bXgX+DG05oBawX2YRc/eZ01ylJZwW3hAjOLMzoFuHTiUNtLvTLpj35mt7BYU32if1JcISGjOBa5CEhu9ur94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsogayB/; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsogayB/"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-86b90133ae8so185828b3a.1
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 17:36:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789605396; cv=none;
        d=google.com; s=arc-20260327;
        b=kLYVY45txWMJruxHqZ+KYNkBIEcKaCBe3+XNkCXwr5SUMkhwAydf1SlNh9pd/qDpOY
         TsKAg6XgUUzuJmi/rofwt8m8l13b0ZO7SxmRHodIPVt5alVyZ+cd2ResAkWTXEWmSvls
         yuCH2m8wVHokCzUs9m/SnNXQDuLXEjLUzLvVTxXcBSRSFiUye69cUvVmP817u0m89cT6
         8K9xDdK0T8ZXmmN3B2B8gi2vuRVbWTBF44GhaMwVcCSIYvkr/5PGBh3JPFWVco7288fo
         eSge0WuO0daxfrVsYDAZAe9m26u/JgLcsNvEXn6ybQqKNYgUsD4hmj+kFi0ZKlzUqElZ
         CWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z3t40gbdtLCD1G2xLbWdqCI7O6nv21XGGKYIiPoR+Ps=;
        fh=4K7XBoVwp10gqLS28+jRFVfvuR7keL/IDc14NVDggmo=;
        b=kBGCULNsgaueBecQJE2zVkRjYcxpZXlH86NN5Gj7f7eF1CrUVvAenlGBCfK4skpVTi
         fG1uro1RLfN9LxLrQZQh/CulL9XJfyLjzzUDS69uY/4nSszMA0X3d+YPwId3a82a+3bc
         7B2vAR97pMnH2JDe+ndooWIK8TFrqodT9voaZhf2NNl0V/scLAQjeMm+eQhBHfjmrQec
         Ao704Hejv0HYJXkLLWg1s975PFYu6soF4SIcv7LZCa7oGrAi94wxzTVNS2CJOdLnBVu+
         y1Git5VzGgAYcJyb79FRtH5H6cUxntV0byyKZwM3OGAqtW9ZT44fZFm5mdk/DUnB90Ya
         qhWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789605396; x=1790210196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z3t40gbdtLCD1G2xLbWdqCI7O6nv21XGGKYIiPoR+Ps=;
        b=TsogayB/+IpRHhnz2DwNm62FAk2EHgYbawS3Z6sx3RD2VGhurlv6sJhlNn+T+9zbx0
         COknBFb2b681fvXkln/uR1k0d36lT9jeKImG72cHiS+fGf2sre496ZD+A95YwID5vWjN
         RFt4NQKI2IPOMUPnjYDaM6zGfbWAB/yD9Bx42V7nM2lyjiW8wHEQTr7yqfkviGfzn9S6
         uQfO8chLF2isgWfqPI9t5sar7KMbSUzPNa4u/3wdGXbFAJADOoGYJBfkqYcVUeTazVTb
         KQLI3TKayjbQa1QSzRxEJkfcB94tk1o4CbnrGk/Tk4C2SZBN/LIHxEJ3CbyY18jZE9Om
         tT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789605396; x=1790210196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z3t40gbdtLCD1G2xLbWdqCI7O6nv21XGGKYIiPoR+Ps=;
        b=i/0Lt8DKlJC67+HA+CQioB22NRj570Sq8jj07xBY5MYJ7Dx+YIKlom3Ixo1GotI4ua
         GShoZd9vx3Lwt1SBSLioCONnZhfJTjvPH7gOlO2OJtcJQyeNwSuldFcGH66B7LX3iXW1
         OeBsuMNAOBzVa3L7oRmJqlPbHtDb6gjx65t5ZyUSzBAeoNy6uhgyzthWAWyKRcQHkHkR
         FM/mW+FcrNl48ji9dHL2rlIGjuWfgkaHKZj8/W9h8TPBiGr8DLwIAlMJM+pV6XFQwTFz
         fCVfEcYheFO5C8pS4F4J4kuNuTXlGAkODLiv/cgG2fezSqQtHuoThCd93g0YWxwGJqih
         +OMA==
X-Forwarded-Encrypted: i=1; AKwUvBx76RJWk9Oeyij8ap5a1DkKqBuzDiL88g39OjXZBr/EQOVAMiaj1ehVHTbUkxV01VnQAuM=@vger.kernel.org
X-Gm-Message-State: AFuF++kypsvdVRnCZD2dkSDnsx6wnm5RD1Xco4jE6uoXk1h5OqfqBWsR
	PSDsVHHS32mD/dC8Qsocrb/uRlgtgURE+1qhiDA4HRIdS8e9vmYlqFZSahu/WnUFk5wrneHFaZZ
	jmyre+CiU/m9ytLFZGtIfAWRqpGQg5xY=
X-Gm-Gg: AYBFou0/Z4hyxItCS1Xsvo3aOHtgBFdPKV//W8NItgSus0jEBuHB6A+JK0uMrW3hB+S
	rZy0lD2rLjAqsQB4x/k81+8HgmYLeLQTtSFXJqLi6Ulxeu7frXMXlpllLomNOYVvZ+HBsMmZBpK
	fn+0GgZ85HQOFISZjUFbgN999sXjXQZWZ2CiYx10q8iMh8W9rgMMqVsXahr9wmy2b9B59cnbD4t
	J5l3wUPjbUwlLF2xMp1G4WqrscDmTJrvE+9Re0JZorjdzTpwf5ndP9YTbp09WeOquDs4dSHjJvo
	4EVNsdI76DmSvUFMxZFySTjL1XZtJpmpshkD8+PfKaSF7yrJtc43pBQXo24n1x1LupokSAAD9gr
	AAciUEoySOhqAO8X2rCZ76ofKDK10BdBIitsYfweZLvIekZry7VT8
X-Received: by 2002:a05:6a20:548d:b0:3d2:df:1854 with SMTP id
 adf61e73a8af0-3dd5f403cd9mr11548203637.6.1789605395452; Wed, 16 Sep 2026
 17:36:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910164635.459558-1-vineet.gupta@linux.dev>
 <20260910164635.459558-2-vineet.gupta@linux.dev> <DLDKB6BTHVXE.PFK87O3QY1J5@gmail.com>
 <f575fe19-a5a0-4f43-b1bd-cdec2c6e9830@linux.dev> <DLH1MDZPU5G0.228555JR34D3N@gmail.com>
 <76ca0a2e-dd9a-41c9-90e4-5fd3c9171172@linux.dev>
In-Reply-To: <76ca0a2e-dd9a-41c9-90e4-5fd3c9171172@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Sep 2026 17:36:24 -0700
X-Gm-Features: AcwNN1XO4HwAR37E3WIkB8E7DX_-wst1NccGMR8T31Mz-rEIep-eXEJg6HLexr8
Message-ID: <CAADnVQKKWBV+pFMAStB_-POKveeO83RiXU+VKeua3odSu-Xrmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/13] bpf: move linked-scalar flags out of
 bpf_reg_state->id [NFC]
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 2:24=E2=80=AFPM Vineet Gupta <vineet.gupta@linux.de=
v> wrote:
>
> On 9/16/26 2:02 PM, Alexei Starovoitov wrote:
> > On Tue Sep 15, 2026 at 1:17 AM UTC, Vineet Gupta wrote:
> >> Back when I started, keeping it NFC made more sense. But with all the
> >> nuances discovered in the process, I'm inclined to drop the NFC stance
> > What is NFC ?
>
> non functional change aka refactoring.
> Like I said when I started I wanted to keep the id / flag breakout
> purely non functional. But given that splitting it does change one thing
> (mentioned below) - I'm dropping NFC attribution.
>
> >> and make functional changes - there's at least one which is the
> >> following accepted pre-series and now rejected.
> >>
> >>         old {r2.id=3DA+delta32}         vs cur {r2.id=3DB+delta64}
> > that's a red flag, no? The refactoring patch shouldn't have
> > any changes to selftest and veristat numbers?
> > Unless I'm missing it again.
>
> Yes understood except that it is no longer refactoring.

NFC is gcc probably lingvo? In kernel people just put in the commit
log "No functional changes", so it's easier for humans and for AI
to review patches.
So pls skip such unusual tags in the future,
but keep the first patch as "No functional change".
