Received: from mx0a-00206402.pphosted.com (mx0a-00206402.pphosted.com [148.163.148.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AABB379EE0;
	Tue,  3 Mar 2026 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574618; cv=none; b=BBliJEzVMjaKEOIiMQqrrDFRb9y8Eq3hqngeqMgIz3vpNzZ45rnz2IIF9TPM0ldN1lidLbHL4f/LjQ3lKGcXQll5rmIXSRY4Ghpr9/QJWhCrFBtZ5DoLBLeM49QVJgTepVkaDDPsl22MfXSp6MQzgH+/jWIW8EOnS2gFliqLklE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574618; c=relaxed/simple;
	bh=5PgKjPQcIDTNvOX1xsD0zfKV+N9LdI00RgMx6mvu8EM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGxbLGy8c/ek6UCQqo/TkwmPba8d0Myu22Mw1RktR3fvSuXqQdgBZGtM2aQgvlGHuk8jxVjFFzvyXbgxFS+/nNv9Af7XHBrHtfFb42jPN8gwtZKAwTPb5ZXlgMNscHHf1UP83Z+Fx3mDiKTneYDw82QGmP2YTd4bpx3S4GKxp/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=xZ2+z7CE; arc=none smtp.client-ip=148.163.148.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="xZ2+z7CE"
Received: from pps.filterd (m0354652.ppops.net [127.0.0.1])
	by mx0a-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623JsNBq3864225;
	Tue, 3 Mar 2026 21:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	default; bh=ZfdmONPn4FjGOmblL/8ITzfOeqQUHHnabZikKayp6XU=; b=xZ2+
	z7CEEZoJGIBuK1p7nzZIJZ1b6IWxyU7pED3EenQsNDp/8WanjMDDmrU/AefA4jAr
	M1crET43S5RVERQXbMtJijxHtrofkD8v1uoU3ic+JzLe7f686DE7EFrQRMRSNKQX
	eJy5Fp04r8j4NIgsBi5SCBqZQqgxWnJF37p8tUFzyDBsIyIGG0/PFWviBBs0nnKX
	r0+tJMAYFe/QFqIjb0QuQJo8aWZgGQz/p0hiz99lzIQzfaInWqlgs+qk524mz17T
	KvT5KV3vTCGyCxKJDPrBstdKocbUwRbVFvQnk7xreYNeZvnDxMEWhMuhNCTboJa2
	bDdNna4jaH1P5ag0pg==
Received: from mail.crowdstrike.com (dragosx.crowdstrike.com [208.42.231.60] (may be forged))
	by mx0a-00206402.pphosted.com (PPS) with ESMTPS id 4cme5xk9c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 21:49:38 +0000 (GMT)
Received: from ML-CTVHTF21DX.crowdstrike.sys (10.100.11.122) by
 04WPEXCH006.crowdstrike.sys (10.100.11.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 3 Mar 2026 21:49:32 +0000
From: Slava Imameev <slava.imameev@crowdstrike.com>
To: <eddyz87@gmail.com>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@google.com>,
        <haoluo@google.com>, <horms@kernel.org>, <john.fastabend@gmail.com>,
        <jolsa@kernel.org>, <kpsingh@kernel.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-open-source@crowdstrike.com>, <martin.lau@linux.dev>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>, <sdf@fomichev.me>,
        <shuah@kernel.org>, <slava.imameev@crowdstrike.com>, <song@kernel.org>,
        <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Support new pointer param types via SCALAR_VALUE for trampolines
Date: Wed, 4 Mar 2026 08:49:29 +1100
Message-ID: <20260303214929.8208-1-slava.imameev@crowdstrike.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <c40dd219ea60f810d52576f998e68cc0d731f761.camel@gmail.com>
References: <c40dd219ea60f810d52576f998e68cc0d731f761.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: 04WPEXCH008.crowdstrike.sys (10.100.11.75) To
 04WPEXCH006.crowdstrike.sys (10.100.11.70)
X-Disclaimer: USA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3OSBTYWx0ZWRfX423FbjZeaKVm
 dVWiS+TfjfY/IWJEy6Dql/kldfMk98qeHCcaQVaX4Kk8BOPG1/aM7L7VwpSKjn9KWuf4ASRD/Dm
 QQ1/wp80U6gKTZwa+uSXs+e4hpythTe4A5U0e8+2NzHMbseAO1rh1UFGvkoni8zwS+UeiPf63Sl
 h0xIiRlV3OQv1pOFpFobDxLYIcrTrw5lff/YbVOQK5zRtuicnRbvEPKJajinyH8HmtpbWE6b7xH
 h8nJ5YrRDreirhaLwEpbAAqq/4i0uplC2voqG2mJys3B7EkUxW5zEooAUHAEs+MXDc4Xu+ESvOw
 VJGLSxNqmESYWDMTnpqqrQ6+d4agGOlRfqOSoVUQuafHLGhT5R7h/TEmzRotmpOWejvZOItoiRd
 5vQypCimYv5kERPTl8erv1qFt/uuPgtTM7zoli8k/0oFddxf8b2nH0VVP1eV5y4Vzgyt976Rkrj
 IGURSX5DeDQLnsmjboA==
X-Proofpoint-GUID: GTUDN_qsTkEHEUMJmYDXpJoHnow4Oznl
X-Authority-Analysis: v=2.4 cv=Sbv6t/Ru c=1 sm=1 tr=0 ts=69a75772 cx=c_pps
 a=1d8vc5iZWYKGYgMGCdbIRA==:117 a=1d8vc5iZWYKGYgMGCdbIRA==:17
 a=EjBHVkixTFsA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=T2KQ53IYiC3MXPrxx8bB:22 a=2KvRFfd_T_-xjmS8C1aD:22 a=UM6OcZwZNNcR4jpQYaoA:9
X-Proofpoint-ORIG-GUID: GTUDN_qsTkEHEUMJmYDXpJoHnow4Oznl
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11718
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030179

On 2026-03-03 20:05 UTC, Eduard Zingerman wrote:

> > @@ -6902,11 +6921,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
> >               }
> >       }
> > 
> > -     /*
> > -      * If it's a pointer to void, it's the same as scalar from the verifier
> > -      * safety POV. Either way, no futher pointer walking is allowed.
> > -      */
> > -     if (is_void_or_int_ptr(btf, t))
> > +     if (is_ptr_treated_as_scalar(btf, t))
> >               return true;
> 
> I'm probably missing a point here, but what's wrong with Alexei's
> suggestion to do this instead:
> 
>         if (is_ptr_treated_as_scalar(btf, t))
>                  return true;
> ?

This reflects my belief in a cautious approach: adding support
only for selected types with tests added for each new type. That said,
I can add the suggested broader condition and make it pass the tests,
but I cannot be sure it will be future-proof against conflicts.

I think the broader check like

	/* skip modifiers */
	tt = t;
	while (btf_type_is_modifier(tt))
		tt = btf_type_by_id(btf, tt->type);
	if (!btf_type_is_struct(tt))
		return true;

might have some incompatibility with future changes, compared to
explicit type checks for selected types. This condition is
open-ended, including anything instead of selecting specific types.

This broader check also needs to be moved down closer to the exit
from btf_ctx_access; otherwise, btf_ctx_access can exit early
without executing the following code. In my case, this resulted in
existing test failures if the above !btf_type_is_struct(tt) replaces
current master's branch condition

	if (is_void_or_int_ptr(btf, t))
		return true;

The result for: 

./vmtest.sh -- ./test_progs

was:

	Summary: 617/5770 PASSED, 80 SKIPPED, 82 FAILED

with a lot of:

	unexpected_load_success

Compared to:

	Summary: 692/6045 PASSED, 80 SKIPPED, 7 FAILED

for the master branch.

As I noted this diff, closer to the exit from btf_ctx_access,
makes tests to pass:

        if (!btf_type_is_struct(t)) {
-               bpf_log(log,
-                       "func '%s' arg%d type %s is not a struct\n",
-                       tname, arg, btf_type_str(t));
-               return false;
+               info->reg_type = SCALAR_VALUE;
+               return true;
        }


> Only two new tests fail:
> - #554/62  verifier_ctx_ptr_param/fentry/pointer to float - invalid ctx access:FAIL
> - #554/63  verifier_ctx_ptr_param/fentry/double pointer to float - invalid ctx access:FAIL

> But I'd say this shouldn't matter.
> This will also make selftests much simpler.

Yes, I decided not to add support for pointers to float.

