Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C18937A48A
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782126582; cv=none; b=S7PNx3GfITVPPwD+i2IRLlZKoZ3w439Q+vUziXP5bIexedLXAVoKCHHZI9ch5s75ALMEd+fIRFl8c+1Si1d0FkDxZDeYLBaOZZisfSrjU/FUP7giywpkXEruhS48y92UOlkKHNjpuAML3a3b+DmuSylzVOdbxalhr8zpS3VlJIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782126582; c=relaxed/simple;
	bh=tYPP06dJbplDehUpPstvRgVcRmR8WzCL5yROKuM5Fyc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=B30+0CfsWNh7sfDXZVhx/0SjHANqCFheQxWHctQWvIbV8WxFprKntGNTENFGiVb34OJxO9V0E4InylWjBGTa5ShWPPlE4gZwsDTfMhnycaGEU3H9NEuF4UtKgirs8SeDAehL2nNrLjgwmL9px4045CMaYIN8ffumXfYfOt49doc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxbmo+dS; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxbmo+dS"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-139a5f4ca15so2732478c88.1
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 04:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782126580; x=1782731380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xIWdbLLEg9dBfFSLqVtIUmlfUVdjnpVzN85B4SdiLpU=;
        b=jxbmo+dS1Mbbbwk5YD1ce9M8jzlGsXK+lfOkm4C7FmdPQahzPKIAeWcSoaknlr5Cdy
         r6NFHT/2gPkBtwOpxU69Wtxu8uI05QIrWoyVikfJFAcsF+yLJU1eiLjuLvof2JBQAGvS
         +kYhUUF2zxbXPUku1B/qyWIOpUjyl2tFvp9TlnIskrMn4yZPCNlEl8sK2/cLAeUepxfa
         vNA/OLNrKel7bg/xRJzY8G1iHzqC1TXuCEKF7oUi+J6Zss3lXBoLzQOXeaoyJqv+BZMF
         4FtzcwJ/z/x76g56rHtbIlQJZ8wIKlUm/UTw0by4soR32OAz5Cba6e581r8VU/1Dwa1M
         tKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782126580; x=1782731380;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xIWdbLLEg9dBfFSLqVtIUmlfUVdjnpVzN85B4SdiLpU=;
        b=U/Fqc5fcHIO1Z7MOACN/z3S7GXhrfx/HodwbCG7ladDtmOoJ3rVqkx/qD19rB4mg8i
         XZpx+bTa61hWmmGqUVXxTBQloQMUOoPEPX22dEVtGdqDs/NoPIQ0oQFdHiGmPNpvdAgV
         RkyijwRuWwg3O+CbSaqM2HBRjFokVUOEVu9x8Bu+FYMLKpz2h/ZybMoZEebmSPpMMyhi
         PBQsDrRtRzQFoiZebo6AAZaMob5ZG6tEo7O76ESFdYV7pytmvGhB7CoPTCqzj57wpa/m
         PHocvJX8+pDz8wPYuchESzCd/RpSQU0R/K2UvVQsu98XTrmgD0ONw8E0CoUtsjyxOfjg
         pn+Q==
X-Forwarded-Encrypted: i=1; AHgh+RpDY2S9bCYXxAZ9jW/RNiNraRzt+hAdyhIhENL8lyR1SNAioreJqSi7PQmiVCvijMqPFiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKg+AjXq/nstf1OWy9CJquMND+lcNrfe3fErFLvnhNcguUUfcg
	lZtCqiA5Z1G24KKJV8II00f7Cwmo2W5Zf03U/xIYsmZtqCBzWzg2w/P8
X-Gm-Gg: AfdE7cmJOw52N8BJcxNJ/auArcvuADHdNeNuKqyx1qLQoJ8uLjlJyYYOEQqd9WsM2fQ
	+8SaHIrQK7klUuVbJ7qDvkLH56FxDFluPN/hN7z0zYN3CJKlkYMxB/1GtBnWB9D7bt6FFUz27TP
	S6x1SOsxSeC/VfqksYIYxsBVZ/BBQFFRU8htUnvwom32DJaoUXSv8Q0j1myXCg57sisxkMcpRsA
	ArhJcHhISYQx0Y2bKOdwHAgqPitBqY3xsk0KuBNKhh+DeLXWZWUjxunvncRLNFsD9Jha/Tmr5JS
	wZfI7nmMVGbgretFUCKohpxHD0HdRNqjdx+fjx1XHyS8SsmNkX1ktyZotWy/MWHquiWZOYzmSX+
	xFYVxnhFpzj3nagglywYZko7NcCZfc3O+2yozBEU3gv4VY4jJZ3EJxlzJoTFEVNp//IwTrAtyiH
	OHDuE+RuzT0vTrGVk97XgzK4wR/7DQgg==
X-Received: by 2002:a05:7301:38a4:b0:2f2:6dde:df66 with SMTP id 5a478bee46e88-30c06e303ddmr10114940eec.22.1782126579977;
        Mon, 22 Jun 2026 04:09:39 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:2bf0:60e7:ae00:61b2:c320:bcb9:eac0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bd8d6c7sm10643390eec.16.2026.06.22.04.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 04:09:39 -0700 (PDT)
Date: Mon, 22 Jun 2026 08:09:33 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Mark Brown <broonie@kernel.org>, Alan Maguire <alan.maguire@oracle.com>
CC: peterz@infradead.org, acme@kernel.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH perf] perf: Fix btf_vlen() signedness errors
User-Agent: Thunderbird for Android
In-Reply-To: <ffdbf003-5f08-4db8-b633-7ed053a738f1@sirena.org.uk>
References: <20260622103418.579115-1-alan.maguire@oracle.com> <ffdbf003-5f08-4db8-b633-7ed053a738f1@sirena.org.uk>
Message-ID: <A52F0C17-9617-4F5F-9537-C9643F5EF347@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 22, 2026 7:53:40 AM GMT-03:00, Mark Brown <broonie@kernel=2Eorg> w=
rote:
>On Mon, Jun 22, 2026 at 11:34:18AM +0100, Alan Maguire wrote:
>> Commit f7a6b9eaff3e6 ("bpf: Extend BTF UAPI vlen, kinds to use unused b=
its")
>>=20
>> extended the return value for btf_vlen() to __u32, triggering
>> errors for cases where an int was used to store return value=2E
>> Fix these cases for perf as was done for other libbpf consumers=2E
>
>I already sent:
>
>  https://lore=2Ekernel=2Eorg/r/20260617130038=2E34534-1-broonie@kernel=
=2Eorg
>
>which I have been using as a fixup since I originally reported the issue
>since Linus' tree is broken, Arnaldo said he'd applied it to the
>perf-tools-next branch but it has not yet appeared in Linus' tree (and
>it looks like he forgot to push it so his copy isn't getting picked up
>in the merge either, the last update was on the 15th)=2E

Its here:

<https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/perf/perf-tools-next=
=2Egit/commit/?h=3Dperf-tools-next&id=3D776bd9ac834556ab6ff6b7ef74b71ac53d3=
7855e>

I think Alan's latest patch has one more hunk, I'll get that one in and th=
en send the pull request to Linus today,

- Arnaldo 
