Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE3B385D73
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788728720; cv=pass; b=T6oQJu3+/HgEwXA2vAk+ioGg81TWEkuQCnJfj5ZrYw7EdwhLDzcRkaOpqbfm5zHTEEPT9iXwo/1f0T85NESnX7zrY9exDe2+8sR5q2b2WXyN5ugFSL2FwnV6c1Cve2FA/FL3McL03/CznRfpgH9QSXxe1XG5uOB0kBrG48dZdHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788728720; c=relaxed/simple;
	bh=JJHf59cfk5vlCc69M8wtJL/JSKMeYLZOpA3NNCHe4hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMAG81tTEYVwfrYq/QTG4dCTjhICP+vLmdDFOSlUEopUBDbLJPRY+IPWfU0+UOSmTe4u0jaYplEPHfCrKWDW5D+200FE7bpkm0BwJPrIsS8kBdbYLAaVB4bGcAlGMcR1D2dwC1/14YSKpPwKyFRMdE5yLTttFsdwuRN7t8fHek8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyN7SpfW; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyN7SpfW"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b754cc3b6aso465044e87.2
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 14:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788728717; cv=none;
        d=google.com; s=arc-20260327;
        b=qYBPItV+70kzApVXtxfAzRTTycDnWZMWPrG6VB3Czu8oXqNByz+KAmyjczJAQKDXH0
         KbIc0KEewJ5Ez29/pbl0j3gOZ5i0LejBls+oWv9uODfhAhMAaPDhcVTdSQZOnVThAjzp
         MYX1VPsxAxk+2G/N81xwuNAbmnvT73xaPOI17hgo+w+ne+DmycEO9LwdizaX9DVXr6Nt
         AccaHYAKXLRgsEJ+zsgnHTBRAvjg88GDq6/nzQ63SNuIbGpUukoE7KOBJR6KZQfgqM+Q
         HOiseKh+oW8cuMt8ltU2afDYC3gAnVstZGaD+a06EAA97k81NG0G6fReWZTkNHhO/Gu4
         DEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JJHf59cfk5vlCc69M8wtJL/JSKMeYLZOpA3NNCHe4hY=;
        fh=b2tr3FTe5K+mhoXh0K5HqGFdzpb5r1/+QUd37ySqxIo=;
        b=Qr9zRFK6jqjogIALAfXFZHQkJ/6ykApiPqQl2nrbK+kRWNTh06+O2K/Frd0ds4CzWx
         IQsyVqBTbQowa8UVN1uJqCtl+E4X3PuPgdXliTYQTkjPr5+z088aAQGABbI4kvB7781x
         COTnrrEBj9P1BjUuYCFwt9xvACsenPmDm+p5txH15A5PP64jKY3oN0QVCC+CCvZIO1Vq
         3bkmtn3yh+t1VRaCJGl9vJRtBlAnE8Ky/XgSrT2B22Fqx1Hmjpl2LU52oMgkZe382A3d
         UkaIosiRh294+V/sKEMKg34Yx0d88uzhIG2A+AFT2tILFEVzprAMY2ly6cAG7X52nOlA
         suYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788728717; x=1789333517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JJHf59cfk5vlCc69M8wtJL/JSKMeYLZOpA3NNCHe4hY=;
        b=FyN7SpfW9h3+bE2nMZiuDWVATRRrWw3/o7h5822dQC2S3YC7H3gT0ScGmPKfXg4yDk
         CaIdJpQjp0WSxNbBK3PGHqq+lPLKx1tuFLRBLygSG2zcmBZbCgslicizB6T9NbrOOkaV
         bHWzywyN0MVfVPpbUWY34SWVmIAybed+z/i2nrTH1dfkEWICKZlxlp4/LIU6dIC1RlK5
         1WSZsogR2O6PaDzz5lwuJcpaRye91gfExnp5+Tbk4WGCVZQwKzQWGh9keHJZx42NNwZR
         ofShlcFPM+3JiJifM4YbIeZSupAI3ZDEjAl0wxAtnWO3J4Az8KQewbUNmefOppOkF63A
         YK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788728717; x=1789333517;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JJHf59cfk5vlCc69M8wtJL/JSKMeYLZOpA3NNCHe4hY=;
        b=j6orumTFCZhagT8nRdxu3MKjfVA0gmKs7oSDPU+U1CYOMVOemBhRIaiF5XmeRuBxRO
         iQy63shMuCSObMKlgr+ad3kHnIs/1Ysyw4/FHVEIclnHxVw+K0F1SCeCezr5XSkND9Re
         kZ3Dg9JZXF6SXElT9qen5OenlzkXqqXfl9BzcAlQsvgUA1G9Npf1w4C+lWCuxCIVA40t
         qWq+O/hlAObZKG+TFsxxRKumfFwJRgEiUOncOYcERBVb6A5W+/ZAAUI4WkTi9CyDDBO+
         N9pDsMqNG8uPY1Ovcn3/MkLo4i5kLFbBblXqb4/tFh98fsDxIT9SEF2nWNr/NlWYGG7n
         P4NQ==
X-Forwarded-Encrypted: i=1; AKwUvByJi5NatvAAf0A1DCZ1/ecIUShluRFK0GbjrTz35eU5UaEfdlwRa1Qs/yIuAS7BOXHky/k=@vger.kernel.org
X-Gm-Message-State: AFuF++nzy6Y0Z31O70NibC1/Dw9Z9KgT00SaAsdhOMsQrs6d0W7fhpU+
	OZURRhthi6j3NPeKz0lfUSyJ6Gxi6rhSFG5biI/e+xqYfV0OC/9W0vkO4qLtkYeitszCqOr1wbn
	+AIdLhL/V383mSv4UmWPN852CijA5/aw=
X-Gm-Gg: AYBFou28/Sx7xkaosc7iUsdwcL6Iae2qj5ubzYn6GWIFLGoQUxmbnc6nr0sYDwGPDCc
	B8KGmjreYjMb3wa7e0i1uq94WyoQb4osjDzyOEtcavaw/tpZejCSISiJkKprm3wZw4w0HC/Bzgx
	usE8Gimtu+zkdHuL+sEwJFuHKDi7g2tGsPasxHpw7T4Efc5x1W2/O2ZwVe4/2bGKBTTEMirWPll
	VSzWE9hIlxLZFrqo/m/Id2I8oPNOSJFYhIOyj+yOoTh94N+XTRYp9TJTZ4DEpjbs41hBanX7OBp
	vlajZJhlfYvt8FxIyNIXFelNSwDgUyZAfNAgypLRxJ3WDTaMXpLEZ6QJE1/1C86IvArcAiMPYDs
	CufU=
X-Received: by 2002:a05:6512:2521:b0:5b4:9fba:dc6c with SMTP id
 2adb3069b0e04-5b616f09015mr2983243e87.15.1788728716688; Sun, 06 Sep 2026
 14:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260906-perf-gtk2-v7-0-1ece839fbca0@gmail.com> <CAADnVQLrga+tx0QCUkviGHqbk9Q6a7bmk3oAe51ZrLhQgRaw5Q@mail.gmail.com>
In-Reply-To: <CAADnVQLrga+tx0QCUkviGHqbk9Q6a7bmk3oAe51ZrLhQgRaw5Q@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 6 Sep 2026 17:05:04 -0400
X-Gm-Features: AcwNN1VfE32-AxkuqqKFXwQZBnRH9Q5ktj20CyevInVOMud57lXIeFkz6ak6xcc
Message-ID: <CAEdQ38EMGjp5RbvZn_RStu1=OOS3H+VT8xHFdnEaVC+dof7Thw@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] perf tools: port UI from GTK2 to GTK4
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, LKML <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 4:59=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sun, Sep 6, 2026 at 1:13=E2=80=AFPM Matt Turner <mattst88@gmail.com> w=
rote:
> >
> > GTK2 is long dead upstream and increasingly hard to keep building on
> > current distros. This series ports perf's GTK-based report browser to
> > GTK4 and fixes it up so it's actually loadable at runtime after the
> > port.
> >
> > Patch 1 does the mechanical port (build system, widget API changes),
> > including the leftover-GTK2-call and signal-handling fixes that were a
> > separate patch 3 in v4. Patch 2 fixes a runtime issue found after the
> > port that prevented the browser from loading. Patch 3 fixes two stack
> > buffer overflows in the hierarchy view that predate the port.
> >
> > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > ---
> > Changes in v7:
>
> Matt, please stop the spam.
> Wait for humans to reply before respinning.
> 7 revisions in one day is way too much.

My apologies. I figured it would actually save humans time if I went
ahead and addressed all the sashiko-generated feedback. Dunno.

Is there a way to get feedback from sashiko without mailing the public list=
?
