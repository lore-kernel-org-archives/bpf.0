Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.148.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793562910;
	b=F4gZgzcjaOlBJVfsEePGPL+SgOJkTQ5UikHsyiq1Bkg4SaxpZ5iWxthkZVcP9k9c20GZ
	 LPF1kn54gsK+beRkPI4ycoEOkYGOVYVQy/mNhcf4YPxjjiBsQ9mUhEAwfv1znMNLD9LgC
	 MAfoDiMiPUUhCePJy56LxVSPN9XSUtnomScwdOCUMXDHpugSa/0r1v87gQWlXpPbKGmDh
	 B39+M+aBWSEef7kN9T1+Jg56rrqGShKLWCG5X1GHdnWknhAUiHfYc2pcou+JJS5MMDoD+
	 gjFWPtHBRo+AAWn0lwD/7a+xSdkfaTnc1lUnA2MFXEH2CKTXKPd/NJCclqUk3wJ8FKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562910;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Cu4b/AJAXtIPxIgigkKjXnS7hlbxXvUr/2CInjv64AE=;
	b=lkRwQeQXrYtaNRXmUpZRU20mrCdPSqlOdtvHEkQXdaVr3yHFjUkIm4QFf4qqsUsN49tV
	 yjFUt3i/cxVuHCeuqKspVNg/A0h2tiIAfvixIhJmiJ4tmbKF1PA+FKrYFJ/U/yY/hHqrR
	 fNQhSYlf88mZRbdsiSVPa3TMv9l8aC9N5R1zHEDUl//8oUQWxlBV8XGPo2qVCnBaKBtDN
	 CnUMwHewPDXjwWjozAEV/MvigM/ctwdlp5qaxNAnu0R+X81e12OsBg2yOaNT4vNWlzsFj
	 V3Zc21I5dhnQutZv/Q4a0vGoMs14iGPXSkblaOArWUhzUIF3JeqwURI2E0C3JrPuMcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crowdstrike.com;
	spf=pass smtp.mailfrom=crowdstrike.com;
	dkim=pass header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=d0gP+igQ;
	arc=none smtp.remote-ip=148.163.148.77
Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E1B606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 19:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74E1B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=crowdstrike.com header.i=@crowdstrike.com header.a=rsa-sha256 header.s=default header.b=d0gP+igQ
Received: from pps.filterd (m0354650.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1DUOKk4168530;
	Sun, 1 Nov 2026 19:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=default; bh=Cu4b/AJAXtIPx
	IgigkKjXnS7hlbxXvUr/2CInjv64AE=; b=d0gP+igQSeJy4GkDo2fZVf9/GS8yE
	2DBRcPXkvTwR+yy45x6glYibsFInl8/EuFWtnx5BaST+AZQ6CfqG1ELBgVF2dH9v
	YKlrFqqkBvYNxqAUqFYnzJw6ZpCIbrtxSeknD/uHA62dYBsKLJsmAQFZqOI9uXrm
	Kex7N7+BE4akYbqESr2NtYnsNNTOe7RTFKx5wSLKYmwfF/c5N0IlOy+vTiOl6tph
	/EmVupaRyjfmS211tGXP9tIPLlrJSKvuMEsKqwqrN/F1GhMgBXp8cRjW3pQBDh2n
	hTQWmkw8UXP4khhcZS7S7vA60iEr5P27b6E77Cp+9NSS4gpKQwoMAW/xQ==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4hnvtc1jh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Nov 2026 19:54:56 +0000 (GMT)
Received: from LL-DJCZ134.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Sun, 1 Nov 2026 19:54:54 +0000
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
To: <bpf@vger.kernel.org>
CC: <andrii@kernel.org>, <martin.kelly@crowdstrike.com>,
        <slava.imameev@crowdstrike.com>
Subject: [PATCH bpf-next 0/3] libbpf: Follow-ups to BPF program manual loading
Date: Sun, 1 Nov 2026 14:54:50 -0500
Message-ID: <20261101195453.3859308-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH006.crowdstrike.sys (10.100.11.70) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Proofpoint-GUID: ntwx-njLzPT81L6fBQJzLGa09TTcYK6I
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3OSBTYWx0ZWRfX6OVzVtOsuW57
 FuXJezHLlwQOiOazCbbBGs47jlYS4L8/SQJHuHKZx+sKJZQCJJiu3kZxSCrdBBZkyNpWqGWwp/k
 PaQh6NNk6iNP8MnTNPDBH05gNW9qjxKStjYlkP+GZaR+rJEf4VN6
X-Proofpoint-ORIG-GUID: ntwx-njLzPT81L6fBQJzLGa09TTcYK6I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3OSBTYWx0ZWRfXz1h1dE8WYjL4
 KHf564E5V2iEF50QDwmPB49snpPsB/dq+XAB5Dr7kFd2pdCK0TZqU0i/o6QXJuOBJWoi1i0b9fU
 iYIh2l/pYoO2G/nkiRaU89FC/GNSmqF9lJv0c4yGKwZit6ltExEymJhgW8IV5E2x7NVNlzy4CS3
 FZD8rNZ6HBnLlXAY2/OKXp3zsKB3rQoPAqombEUYBa4HL2LHeKyqRDtvut6HdGTR9yL1Egtl7ac
 pegKJStvNGQZLGdT2kSbCzXBQy/7/H2flnWNcTIbYN6gbXuhA6VWxjGpLC7n2szH0JWvUrW0hdE
 yj/8o220GlPNXHpBpuasMDbllQTBcRejFVTwHTSh6B9BBp7dfXbYJ2ex9Ab7lKAEtjAoD4Z5GK/
 Hdjkz3RrHazPglQs3kj+3IA3R/dSg8Kw56+bxV9fHg31oUbW6neDXMhU01NnjuhpNrCacyGlY+k
 u6IIeCTiz4OxSK/wXVQ==
X-Authority-Analysis: v=2.4 cv=V4boQuni c=1 sm=1 tr=0 ts=6ae79910 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=t04HzT_fAfAF5W-3wVZy:22 a=VwQbUJbxAAAA:8
 a=pl6vuDidAAAA:8 a=6UH4ogtkg5L0KfqMFyYA:9
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11953
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010079

This is a follow-up to the libbpf BPF program manual loading series [1].
It addresses a few review comments made in that series.

  - Patches 1-2: Split the veristat conversion work into two separate
    patches, one for the actual conversion and another for the arena
    selftest update.
  - Patch 3: Small libbpf cleanups in the manual loading code, and
    documentation of when bpf_program__set_autoload() and
    bpf_program__set_load_strategy() fail.

[1] https://lore.kernel.org/bpf/20261029223348.3730738-1-andrey.grodzovsky@crowdstrike.com/

Andrey Grodzovsky (3):
  selftests/bpf: Convert veristat to BPF_PROG_LOAD_STRATEGY_MANUAL
  selftests/bpf: Test arena autobind with BPF_PROG_LOAD_STRATEGY_MANUAL
  libbpf: Clean up BPF program manual loading

 tools/lib/bpf/libbpf.c                        | 15 +++---
 tools/lib/bpf/libbpf.h                        | 14 +++++-
 .../bpf/prog_tests/test_struct_ops_arena.c    | 48 +++++++++++++++++--
 tools/testing/selftests/bpf/veristat.c        | 20 ++++----
 4 files changed, 72 insertions(+), 25 deletions(-)

base-commit: eaae576c34d7e001767b6845a5950b0b8db3e68a
-- 
2.34.1

