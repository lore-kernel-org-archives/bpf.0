Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531E231195B
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915250; cv=none; b=ZDj8V0oGHIZAWeHq2kk1fXREf+RVRmeH+lzjfH2mlXESIHALQFoD5i2uBGwtW0nQc93ehwTd/SD0Rx9wuLIFgGg9dWpRFMN35Ie0yYG3GiOxF17ZFpCDieqr5U1JD1Ln0a8sSxAa+yigHjSv/W11V1Fu6/daabXstqBIVfEYr9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915250; c=relaxed/simple;
	bh=/hrfveLb1uPV4VCGvpq1d49nVZzabJSPa2N33mW8rPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WW9mI3YRDr+veNNtp6vlY0JQmusYwJ1DhHg+alvAopjTvnUiyU9RSPqUXGV514RAk684fOdNW7X8AzCBxedaxxMsFT+fPqkfEotuY02J6nCdTTS6GFN3C67aU59hNOGCJi7gF+G+IYgoMrmzSsC2m0pppblbRFyNgzzEuGC5S/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WJNZ8BIo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h6tCW2GU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WJNZ8BIo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h6tCW2GU"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A99GQ763531
	for <bpf@vger.kernel.org>; Wed, 1 Jul 2026 14:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8bUSJda4ilqPSsr+kj3ujHasO466L6Tnfyx
	nT4QYlUY=; b=WJNZ8BIoBcePfmJQhe/ivluEkiTCn3a1RjKO16JwiiD2FZ/508Z
	Al4gxTNu9JO0SGGGP74S+fFmr7FEZ8K/3IeOWrzwt29t3aDfX7KQNKZkZ/hWcJOk
	nzS7TMd3BGQeRpR/yyijMgVUnM1VV5nW9VG9hVSBl6OAzqtIB/PMVyEprb9MmnmJ
	NEyYN9uvqjXje1vWHANeJI30FsbjjKYYHGUd6Qm3bAv5M7HfZGyHCMoBUYx7fxSM
	tGWu/FwwP6c3sug/1gzYQb/5E92xczd8Lq0JvvFDYem/DEPwMU84Yi0pdu7pX8qb
	e1I1Tad+GT7ZG4zJt1/pKzvDw/N8OV2Q1QQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jktcjfq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 14:14:08 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-139f02b1fbeso3147453c88.0
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 07:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782915247; x=1783520047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8bUSJda4ilqPSsr+kj3ujHasO466L6TnfyxnT4QYlUY=;
        b=h6tCW2GUcZdSKvPTzfSkD+C7vXzcf+ELFzHns+AcaCPA+20Vmm7GyxlJDHa3IaucZB
         tMk5X3ujmFCDLVrBARd5gdlYU7lZYJ6/Vkfsc94MOEUj8rI/bJyaZ+wfzgsa0GaBakUS
         kgttg+GAfE+TyVs7/6uvboMLUinTiBBVNa36md2HMsrTuMUzIYSvl2D2ei4qgWH7X5tt
         yd1c1e2vsVyjzqjpmyliTddW2ugFZGMETZR/ZX7qrke8gOJv4TnMrWR+HWOJVJmPkdUC
         wbVolpOxy0IgSCHoPQt64SIaLFgWpOAVTjlPY+vBMFcwLq6DRW6LcPOmw6JHe9ESgq34
         zc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782915247; x=1783520047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bUSJda4ilqPSsr+kj3ujHasO466L6TnfyxnT4QYlUY=;
        b=lO3HI0IhBe4VXX02+E+A12lKzQllsNcoNy46zVCWpq8OfWTNja2Mv/whzbIoy5EyKm
         tj9h5iOSHJ9ntsMFAtDYMeJjhwWda2ROp7/Io5Oa/6fJHQqPp+UtjcvCJBpeQX2wiEnt
         uCcdaIIU7QUt9QqlshZHI1+EIx6nD/ECznGo9mYMZFPnDLT8ddhcsLl9aLJIAAhTrV4t
         u3iXIntfesQhrL+Yk1EzVd30ELG0YoD/riak1Ti79ZaYCz7EO72DNJuCJ3QECbgnqTV3
         FBZ3o/2Um6A13AB5a7gEqWzv5NTLd3lYlZz/PkKvLD8IB4LjLVovObCVV/+k1vhgQRbt
         9tpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/8tVZcHFo9ETWy5ooOgXnU5Ahi0fhtYiSCJpTCyrfA1TPetMUlnCe9PjNuZd1z4FAhaD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsAPB1lrd1EG+Ajzg12D5JdXRK4zeTTYeHw6YbS9cvXb0jotsP
	8gmzE82aXkQVYIdxnXPBGuu9tmC6uMBgomZ5ZianrWsOUmxnfPhDzM+dySmhcwyO/EckECWWxDn
	byOE1mJ8Xb8FQCiI12QpjIiXaEFeMIImx+/4WcIY7ESh549OzgSEFYwA=
X-Gm-Gg: AfdE7cmXpW5t7wDrMaLh/8vnZlKTBtbnfhAUHF6A5t11W1Y386SrrV5Na7VC14ds4Aa
	PLfjOU5Z0Q87tFeMY4eanYy4vP4+RYKjm04BkipdW9q/f7w44xGte1KwzbNr3H/JyZbkmpKJKsm
	QV62B2Nphk+8CJ1Yux/ew6ut7P9smD1IaKTdFO0ih69WNIdhh5Hr5r4XELaN/nKlbkUMQPPqAB5
	o0KQxEiXrU6eUhU0X9lOJEcc4eCP5TGtCBI2zu4S1E+M64luPO5RmNMh2K7Dawr1R6R2V0nqGzE
	NGWazGBkSAJcTnvfWaIOj9fg+vGZvDd5ZxkyRM3pkL8Y4f7qfouNGHqGBkepa9T5rR5H+zZsq9u
	inyRdJgObq7HCGeT9Y5EYn1dWC56iScxkPOA29hk9uRmBCHN6/rJO26QdIwSvP+vgdQGYSKIynn
	ym22VQWlw9w7g8TyAsyM+c4jRNDJUNUxM4Iu+Q
X-Received: by 2002:a05:7022:922:b0:137:ae1d:5b5c with SMTP id a92af1059eb24-13b390f6342mr920111c88.22.1782915247025;
        Wed, 01 Jul 2026 07:14:07 -0700 (PDT)
X-Received: by 2002:a05:7022:922:b0:137:ae1d:5b5c with SMTP id a92af1059eb24-13b390f6342mr920081c88.22.1782915246492;
        Wed, 01 Jul 2026 07:14:06 -0700 (PDT)
Received: from hu-mchitale-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-13b2ab0fc3fsm22644741c88.2.2026.07.01.07.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 07:14:06 -0700 (PDT)
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Subject: [PATCH] perf: record: Clear BPF headers if not needed
Date: Wed,  1 Jul 2026 19:43:47 +0530
Message-ID: <20260701141347.4098670-1-mayuresh.chitale@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE0OSBTYWx0ZWRfX95hD7FsdCc12
 JPq/D808i8xXv66Is7HrpDU1o/MfS2MdqS4Hp3FtDgTUDMLjvzc2sooXF+mIX4R/wD7ARn5kpi8
 x+lT5lL5XOFlm6an1sHb93V59K9vSFQ=
X-Proofpoint-GUID: sMRSFDGAA49tlWqNqRGsxQ7tLKV4u05Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE0OSBTYWx0ZWRfX7XMTMmDXkHJq
 z9JAUGAzXSLGNTP33Wey0/Z25v5ZFabZlD/IpGKbHUHg64dTAR2LPRvr7v7/n3C+7FSkb87vaEK
 hMoEJlbPVjfcLtRoIGnC+NyktMLhVHLAXMHK4xVS27RFifvseKG4scjF7M4vstliGCGUOQYzADE
 tNMgBbP827x9QHtha4iD3Ctvj71pn2cwq5NRpeWMQ6s6826d3dCCsAvVeHs9eszWqDQDOBZmVBS
 /YLI1IT4nRSnW+COc+z0LudbIfOm+aymGSyr2XmdgiTFmpt+rdDhi0kg4EagnXX0JtpK6NnSDs3
 7hHK9MsMjEeNRC2QZZk50H2QFptG38mo75VjSPun8ngEVbtxklgPMltRYJK7Dqr88FUNQszhSxB
 dS2iPGwPDnqz/+UIsUfOcDOoKn3BDSM+8oHpcPtQ+ag3wDKs/O8HM0BQXUHmtwliKxxpvzDCsHT
 qacLdrlKt6ei9xEEUvw==
X-Authority-Analysis: v=2.4 cv=R+wz39RX c=1 sm=1 tr=0 ts=6a4520b0 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=N4SQ0fxuwrioDB_HzhwA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: sMRSFDGAA49tlWqNqRGsxQ7tLKV4u05Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010149

When perf is compiled without libbpf support (e.g., passing NO_LIBELF=1)
and even if the user explicitly passes the '--no-bpf-event' flag, the file
header feature bitmask still unconditionally retains the BPF/BTF tracking
bits. As a result, write_bpf_prog_info() and write_bpf_btf() always get
called and display the error messages below:

ERROR: Trying to write bpf_prog_info without libbpf support.
ERROR: Trying to write btf data without libbpf support.

Fix this by clearing HEADER_BPF_PROG_INFO and HEADER_BPF_BTF from the
features bitmask, whenever the user passes the '--no-bpf-event' flag.

Fixes: 598de368375e ("perf header: Properly warn/print when libtraceevent/libbpf support is missing")
Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
---
 tools/perf/builtin-record.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e91539055675..692ab7138d2c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1829,6 +1829,11 @@ static void record__init_features(struct record *rec)
 	if (!record__comp_enabled(rec))
 		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
 
+	if (rec->opts.no_bpf_event) {
+		perf_header__clear_feat(&session->header, HEADER_BPF_PROG_INFO);
+		perf_header__clear_feat(&session->header, HEADER_BPF_BTF);
+	}
+
 	perf_header__clear_feat(&session->header, HEADER_STAT);
 }
 
-- 
2.43.0

