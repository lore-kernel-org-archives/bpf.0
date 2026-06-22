Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F15A2D7386
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782127909; cv=none; b=r7gB81CV2nCKm0RG36j29YxtmPVq3fa1FJqn2HF7JZo1ERaLQCn6P8ENfrQy2Q2QVNdaySE6RjvCnfCFLE81HkSgWkO52rpJK3IF2MwvmgPiZmKoZM2iA4IxMozz7aFePvUPNnvA3Pi/PGpO8rMq/8oqirSS9eQn4OZW43cMj+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782127909; c=relaxed/simple;
	bh=KDRTustqNurCNZREaf1pCPYcaui3zDoqOsKxZ4GWsPI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HueOG51Dh2MeuygtP8t4P7rhw2S1bsA548qX8naHTxwERWgR+O3DD0EgSUe2trJTWsb7tNdTaewz51u6pNUw6+/JGt/JiTc28T/8VndZgrJfLhLeh3Kc2dWlESvP10j2QH47xsGAZ0bAIIaK58bKX22Ym6sPeHii5D7IFS7CM1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+hOA6DI; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+hOA6DI"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3078e0dcd67so4807566eec.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 04:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782127907; x=1782732707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cKiQyyK2YqfLKDVDbtobty9TrjuyTTupcskU2j0RRiU=;
        b=g+hOA6DICGp1AdtQ0pe09HsN1+XKzy8wBQDXb9jjeTfzN45DMBIYcBxppTSzveIHb9
         p/x0Cy88P29ZjwgTvzRIO6gGQSnD14JY+d1s1+ZMJPf76Qu075PtQmipjNalPUeqCAV5
         WC6n8P3PJlEL6LKtbzY1utL3xax1a+BiTIgqLzSPyUmRnNVFXYdPK/MszNZAzC0Diaoa
         NyXE67bJKaJR5jWJ1Oeohief151Rg1Nb86+wvT3GMTu/23vA7ac6x1bqc6iFeN9p14Xs
         GBQXX5NCLSY3H+LPth66ykNDJKAhcmrMHZUAOAOfXimce1SQ8C/b4BqmBxHar3HUsPdo
         6Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782127907; x=1782732707;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cKiQyyK2YqfLKDVDbtobty9TrjuyTTupcskU2j0RRiU=;
        b=FVEs9FNt3eRbEd2tqMtp/DouoKpEWv3azVsQDvu4MDwiUaY39k5Da/cMCo4w7CMfkH
         rjeAd3bKl3e2hawK/MPg9bnLDirvEkQG5mqlwfmhT/nHOGitXvcvzorPpUmOsYmMF0Pw
         pZvFyr5xivV7pM85bq2ol7YQkYMe0nLHMB2VkjVjSM2ZwGMpi8xvIPl/jmOR9QhXB6/Q
         OHH1ogfDA8Z/pT9os08KUvDZCtlxELFAfOjEiFcDJoaAfcsxTU6iEY/tWWGx3JU9FsIK
         iZINfqeQh2r3uh266h+vioxCetmv3NzECYR5Df5N4ZZzmvwZYc3LIt6bk4YNjfHi2hRk
         3Cqw==
X-Forwarded-Encrypted: i=1; AHgh+Rr6em+E0gg/Kl1vKyrJKfOUbWGX8MZUqiSbsRlfcAyE48oc0/MT6CXffGgTwgFjGx136fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybueCJ//jHIg1dLIG7o4x3b+ParRrRcRhl91oZmHkNc4Flus1V
	a6iv6biBA24LhDLcI+ZwIQo2oNRHr6fQbEGOzsjHj1VFL9U0HF0P+uxH
X-Gm-Gg: AfdE7cnNZ+RzXJR957ywSemXh7EMH9054r7+QWeN/UO3BRrcKQIpSBl8KuwEq6SXcJt
	8eBnya4kaOyyk4gQiVvbKaXcPCrQ7tTinYlLzR8VY13t5uFwyipCuAQrFNJuvaQcqJM5fiqZVZu
	jDSs8bcIPRgDo1RAdKNHRWt79kzy9YREW1Klr7+NWZuW2yHvLSQYjDMH5uqUc1KzK1MBbME/qQO
	RDc+UaHmCwTRrDDJIb30mtH8xxXwtxjP50t1gmN1Lmib/o9iqx1jI1oniejnymcaojGGVpmgZAA
	nOf0y9X49vX0pENrj+lKq35kX19xV1iUO2/YBtGLLkl7H71VQIu6EMS2LUEL3bqni8X/MHB+1T5
	9F7jTRz42X9kfIttce1PeRkFmgydJapqjN8SvShkn/D6cRbNi6P+FdHoBmSoS9jUaWgGvKDLhdl
	A4aWG0c+H/6XG4QqTY9zNd4Pr0eGSXkw==
X-Received: by 2002:a05:7300:3b1a:b0:2da:a813:a5fd with SMTP id 5a478bee46e88-30c07156e55mr8418040eec.22.1782127907348;
        Mon, 22 Jun 2026 04:31:47 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:2bf0:60e7:ae00:61b2:c320:bcb9:eac0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1c32csm10815274eec.6.2026.06.22.04.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 04:31:46 -0700 (PDT)
Date: Mon, 22 Jun 2026 08:31:43 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Mark Brown <broonie@kernel.org>
CC: Alan Maguire <alan.maguire@oracle.com>, peterz@infradead.org, acme@kernel.org,
 mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH perf] perf: Fix btf_vlen() signedness errors
User-Agent: Thunderbird for Android
In-Reply-To: <ab95c312-061f-47ae-9202-432aa48afa70@sirena.org.uk>
References: <20260622103418.579115-1-alan.maguire@oracle.com> <ffdbf003-5f08-4db8-b633-7ed053a738f1@sirena.org.uk> <A52F0C17-9617-4F5F-9537-C9643F5EF347@gmail.com> <ab95c312-061f-47ae-9202-432aa48afa70@sirena.org.uk>
Message-ID: <B9C3897F-AE35-44B1-8608-49178BB2E629@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 22, 2026 8:18:43 AM GMT-03:00, Mark Brown <broonie@kernel=2Eorg> w=
rote:
>On Mon, Jun 22, 2026 at 08:09:33AM -0300, Arnaldo Melo wrote:
>> On June 22, 2026 7:53:40 AM GMT-03:00, Mark Brown <broonie@kernel=2Eorg=
> wrote:
>
>> >which I have been using as a fixup since I originally reported the iss=
ue
>> >since Linus' tree is broken, Arnaldo said he'd applied it to the
>> >perf-tools-next branch but it has not yet appeared in Linus' tree (and
>> >it looks like he forgot to push it so his copy isn't getting picked up
>> >in the merge either, the last update was on the 15th)=2E
>
>> Its here:
>
>> <https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/perf/perf-tools-ne=
xt=2Egit/commit/?h=3Dperf-tools-next&id=3D776bd9ac834556ab6ff6b7ef74b71ac53=
d37855e>
>
>Ah, so it is - I missed it because Ian's series was applied on top of it
>and doesn't look at all like fixes so I stopped reading the log (should
>it be in -next given the merge window?)=2E

Ian's series? Yeah, I was unsure about having it in this merge window, it =
went thru many versions, but your question is a fair one, I'll move it to t=
he next merge window and send only up to your fix (+ Alan's missing hunk),

- Arnaldo 
