Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909EF381C4
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791733826; cv=none; b=qtzJFzSGEk03rBSkW4S8lbAKvxdpx+RDowNtg8zkBKZddyqlcGmDbjFx3bk8zZ5KSHOxF3LS2Hra8G6iP8vBzosw/hkhKO3TVpFUt25CBjv1VCLpy/ozjk+QItP4RhL8HMwxCmDM5NEA25QMaG71YjUau0uRc42N2cA5MmiDgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791733826; c=relaxed/simple;
	bh=93Q8iXn4SqNfzwLQUS4BhKha68WsP0LmD2+xw2Tci4E=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U2W0xL1x9kCTa+lew0YvNJp4J9wXi4v/WhHxQR7eE1/2dntYyxafVRh/cc0IrcovzHSOU2LvUtAFKaFgeNtI7kMM3R4zOdKTALmDcDLQoJILSNLROjGBdXRcQ1DFx4/TatNg00B/eWBhi4bz/qQjyWsc4UU108ClQFAyba4p+5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8IRk+Qk; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8IRk+Qk"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-676804a3a22so714658d50.1
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 08:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791733824; x=1792338624; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:msip_labels
         :content-language:accept-language:message-id:date:thread-index
         :thread-topic:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=93Q8iXn4SqNfzwLQUS4BhKha68WsP0LmD2+xw2Tci4E=;
        b=M8IRk+QkVteOSct0XJZsi/Tg6PeYWoc5pzceI3tjJWgjpl1aXdao0UWEAkzIwU//tq
         ERGt/F0AmdjL/Ot5kGTFShoezSFHc2npMb6ytEFe1pmtnapv9BpGSYL/4vFSTv2KgydW
         D0GPyGIg5WAdI2YuCWbE4hqV8XA+4/kkkZox5xjYsoRMY7xsSR1DJ8qERdO0Npa5KccA
         XrNPiX3NADAdGdowdNZfzqqnTByr9OypdvlGjODJoe9e3dMUmF1L3GTWv3YBMrugLwWV
         l71XzJdjfU4ZvkByf95qC6Lq+F9DrFlX7Rq6fjWQk2O0Y4WrtwvQNt9nGDKCpwNzmFtP
         Fl2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791733824; x=1792338624;
        h=mime-version:content-transfer-encoding:content-type:msip_labels
         :content-language:accept-language:message-id:date:thread-index
         :thread-topic:subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=93Q8iXn4SqNfzwLQUS4BhKha68WsP0LmD2+xw2Tci4E=;
        b=I4gxE4bTLqk/l75BERj8/bIulQim8sewdC2bKNOzKicTneQ7lqYuKkN/+l0hUIL8Mk
         +N26TibAClWrvTrlnbTcBVNYnqXhsU43QMrZSWmJtODqI6lgtPyyqYnQEstmYcQfAbXO
         H6z8AxSgKldga/SxTq3LdkhPbiy87IyXyyn68R66v6jdAEP7E8ne3nA875P5M2an4y8J
         mbB1J+Fpct0y3wfx3r6zOcHZt2YfL7inzEYahPJGCJO/JYTUWnXI10xwf0la2lGnhzXt
         faz9niF+rGQU3ivyTD5dkNRGsXM8kUTVnGKeXdj8QTMlhCRUY1J8vgHQbJ3hhAjnQD5N
         QHFQ==
X-Gm-Message-State: AFq9FYJKPBVAoQK61zKWf6REcEJYbUAEmSOkk1tzcBDgkqOiu/vQYp6f
	A+MsrvD/wqGmH2a/1bvbsB4BFf5nT4VI/Fgl7HNkpYHHMaRSZ5P2CMvA/ub5Sg==
X-Gm-Gg: AYBFou32SgwGfRBzAOGL3q1rFZD7Zhtp3PZ+SE9GFFEYTJ9FErnCc/GOzkL45qGW2ow
	7x0JhYkvCeReDY3nrCSWRoIDzBiXYd88dXDNZwz/4lbX4ur4P96pKy+4z0mfVHWd79sVOD8W2IE
	VDrV2uLi+FGtCqVumyMb3KxJ5faplNDN/IeSrBtGFP1Bl3VKawlbHikq420fQRJN8jjxGorya6C
	vEu4uAzwGMTgOpBu2y/l1sDoHfkM0SmtvBD03IKYYCCcyz49GlJxY6qhKkFCP8FOJe/4oem3ZNh
	QRGigvhwH2dEC1MtnnIpCqHHQp007Kfk/TrhD7b6noUik/SHD6vv1DHnbOofmEqzuV1ORBwumnu
	jirE7Y2Nz+i8zhF1tW6a6OtbE2zENNQGKyq04AdHoHUnTrRetD+JUVXLo+BBYMiXJh7XFO3XN4u
	jnRK+dD8ITH0t/e6hTN7+aXfBM8GOXbp+SC/kHcI7AtEWmF7I9mG47LcvSZujJWK35pSlHWH7uY
	HtyrDOLHoNsLWfrK9NQED6ouwl26vHgrFVTXzFjAknLr52C+vSd/rMj5Z10QOradmi2DA==
X-Received: by 2002:a05:690e:43d3:b0:677:b99d:889f with SMTP id 956f58d0204a3-679360697admr1517070d50.19.1791733824582;
        Sun, 11 Oct 2026 08:50:24 -0700 (PDT)
Received: from IA3PR05MB998319.namprd05.prod.outlook.com ([2603:1036:207:1c37::5])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679356073a8sm2616921d50.7.2026.10.11.08.50.22
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 08:50:22 -0700 (PDT)
From: 0xStrawHat <strawhat4224@gmail.com>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Question About Reporting libbpf Fuzzing Findings
Thread-Topic: Question About Reporting libbpf Fuzzing Findings
Thread-Index: AQHdWZg4ret3s7myNk+503cgPsJuyg==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Sun, 11 Oct 2026 15:50:21 +0000
Message-ID:
	<IA3PR05MB998319C977A2E378F5CC7EF54DFA902@IA3PR05MB998319.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello BPF maintainers,=0A=
=0A=
I've been conducting a fuzzing campaign against libbpf and have identified =
7 potential issues so far: 4 that appear to have medium severity and 3 that=
 appear to have low severity.=0A=
=0A=
I'd like to report these findings responsibly and make sure they reach the =
appropriate maintainers.=0A=
=0A=
Could you please advise me on the preferred process for submitting these re=
ports? Should I send them directly to this mailing list, or is there a sepa=
rate channel for security-related findings?=0A=
=0A=
I'm happy to provide individual reports with reproducer inputs, crash logs,=
 affected versions, and any additional details needed for triage.=0A=
=0A=
Thank you for your time and for maintaining libbpf.=0A=
=0A=
Best regards=
