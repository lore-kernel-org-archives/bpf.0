Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4463BBFBB;
	Wed, 19 Aug 2026 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787107715; cv=none; b=YUMRAowvEJMLujBpCB/FJCQAWndsJrOxGwgtfQN5fdTRc2H1B61NUBfi+V2vK9zN0icNTzPKfHC9IIDtHMFQM7u4AU6oiM5S2EyVoON1kzoU3mpNDstKGvMAJut5lTKPnihGcAvGQcWxCU2+irlmAHwJ+YJZOJ3Fi5tzXnuyud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787107715; c=relaxed/simple;
	bh=Gkqf6+TdDU4kKCwXQoTGyMTq/gF29FXKnIKAEHhTxx8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htWBaC6F1/XaGsG2+2F8Be3AiKBQU9cbI3/Lahe6msrNJaQMTv+h/2c+uDhnlGMhZYjjBj8wx/s/ibdS4+n9nAzBizN5MKlJWRRQu7eA1WsuHAH5BOYM8XG1z0byS1yTZoY82YlCh179F5ZzzbP84qxi2b5gyVhPUU74b0qWRow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eZj0SN4j; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eZj0SN4j"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67INlvv51986725;
	Tue, 18 Aug 2026 19:47:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
	aIlQc49jlt3qkVvVgQJzuJ3WbZpTPn7ZJnIHzmU4Rg=; b=eZj0SN4juX6l28Lu9
	/jlParonlm19+BcsfNjrik3QrVCbXgVrmCqCg+1NqVisbXNMEmVT84r2ljvzVjVG
	SI/1YaM7jpp8BN5SNSjP2xzDh52I7GqmCpJnG4zeVoXJIocMVBNz34I/9pE5cqPN
	/DAgNgQbIXr4Wz8ZtDbei8iYgCorlyMQIviqX2UQAoVbX30lJ6Ur8c7f825yHU84
	yzTBlCwnekP30vMgPuFeODN+FLXG8acLf7/b6sw3twUBoMlw07uOWjb7hm+2Vax4
	SJ25LNXo9DBo51k5WCaa9KlZmsnShbiKgSF9PW6HazCvDiZZEJIf2AyV/teu3vWU
	+iQIQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4g4yew90d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 19:47:59 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 18 Aug 2026 19:47:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 18 Aug 2026 19:47:58 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 8C4A73F707E;
	Tue, 18 Aug 2026 19:47:54 -0700 (PDT)
Date: Wed, 19 Aug 2026 08:17:53 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@google.com>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>, <pabeni@redhat.com>,
        <sdf@fomichev.me>, <sgoutham@marvell.com>
Subject: Re: [PATCH v9 net-next] octeontx2-pf: add mqprio bandwidth offload
 for NIX TX schedulers
Message-ID: <aoUZWdZ2fy8rJUkM@rkannoth-OptiPlex-7090>
References: <20260817032747.1765883-1-rkannoth@marvell.com>
 <20260817084212.5d46a501@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260817084212.5d46a501@kernel.org>
X-Proofpoint-ORIG-GUID: 9yteiy8kdWiTkYmUbgy3Lt9LnjLWtCsy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAxOCBTYWx0ZWRfX6von7AQ4WVMD
 P6ugMIZpQ6H6jclrZgw5KGV7UChQaeVi5BQXa5Rn/Z1SkSzZs7trN6bFFzLq36VEsYqGKYLu/Uf
 aZItra7959UA0ThJFN9dzoVR+1sIVLU=
X-Authority-Analysis: v=2.4 cv=Je6Ma0KV c=1 sm=1 tr=0 ts=6a85195f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8
 a=Cp4kMkC2EwGtsqKAzdoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAxOCBTYWx0ZWRfX531VK0Bv/4Ag
 Ybii+zUw6g0K0uBICPE9mYx7G23SeyDc+8cr8qJTZqdC7Yf/VTKGpNTiX4mqQyCPZjkzX4J1jOQ
 Uk8RE2xlAEkN+AXEe5XQgdh3SdIR4V0z8UFA14tqanFFzl37D32qMu1SH1hsP+iRHiOpV4bnEQx
 l3DI8pfStuSJtVmekXlmtnbmDbf6Kx8eEUlibFChAqI4Q2cQlDQBPz1qGh3/XIu/b3omustLaXB
 zp4IuE88Q2df0jbwWmfc9bZRI2OAVH5ikr/mSGJXr8pVaHLhpLjb6JTq9dFQL8Dtx6Ud2q87jte
 kZtJ8K14Z3YnQ31byy+uK5qlDAqg9+qwXXPSmdvmEKw1g2LYk/BLQHV2fL2IT1z4terVLZ9yMEy
 Fp/Qbu9vIrkb62Y1iSD91b/T5G6ake/zKUNRcxbQ949fxuxzCFKHyi0cePx79IPOKEjNqt90Kyz
 h5c9G7FQHAtllA+xqTQ==
X-Proofpoint-GUID: 9yteiy8kdWiTkYmUbgy3Lt9LnjLWtCsy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01

On 2026-08-17 at 21:12:12, Jakub Kicinski (kuba@kernel.org) wrote:
> On Mon, 17 Aug 2026 08:57:47 +0530 Ratheesh Kannoth wrote:
> > Subject: [PATCH v9 net-next] octeontx2-pf: add mqprio bandwidth offload for NIX TX schedulers
>
> ## Form letter - net-next-closed
>
> The merge window for v7.3 has started, and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations.
> We will only consider applying net-next patches which were posted
> before the announcement:
>
> https://lore.kernel.org/20260816155953.072d73da@kernel.org
>
> Fixes are obviously welcome at any time. net-next patches may be sent
> for review and discussion only with an RFC tag.
>
> Please repost when net-next reopens.
>
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

Jakub,

Will do. Thanks.

Resolving these pre-existing and error-handling issues from sashiko (see below table)
will require additional time and refactoring. I've added temporary TODO
comments and debug messages to track them.

If acceptable, we would prefer to re-submit v9 and a follow up patchset to address
these fully post-merge of this patch. Please let me know if this approach acceptable you.

+-----+------------------+-----------------------+------------------------+------------------------+
| #   | Location         | Issue                 | Impact                 | TODO / user warn/debug |
+-----+------------------+-----------------------+------------------------+------------------------+
| 1   | otx2_common.c —  | Stale                 | MQPRIO transmit queues | TODO: yes (lines       |
|     | otx2_txschq_conf | NIX_AF_TL4X_TOPOLOGY  | may be unexpectedly    | 790–797). User         |
|     | ig()             | from HTB teardown is  | starved until topology | message: no — no       |
|     |                  | not reset; MQPRIO     | is reprogrammed or HTB | netdev_warn/err/debug  |
|     |                  | parents all MDQs      | teardown restores      | when stale TL4         |
|     |                  | under TL4[0], which   | defaults.              | topology may starve    |
|     |                  | may retain HTB        |                        | queues.                |
|     |                  | RR_PRIO/PRIO_ANCHOR   |                        | {pre-existing issue)   |
|     |                  | settings.             |                        |                        |
+-----+------------------+-----------------------+------------------------+------------------------+
| 2   | otx2_pf.c —      | If otx2_mqprio_up()   | Subsequent ip link set | TODO: yes (lines       |
|     | otx2_open() /    | fails during          | up or driver reset     | 1983–1987). User       |
|     | otx2_mqprio_up() | ndo_open(), the       | retries                | message: partial —     |
|     |                  | driver aborts open    | otx2_mqprio_up()       | otx2_mqprio_up() logs  |
|     |                  | and tears down HW but | blindly; interface     | netdev_err per failed  |
|     |                  | does not clear        | stays administratively | txq shaper restore; no |
|     |                  | mqprio.rate_limit or  | down until the qdisc   | message that           |
|     |                  | the rate caches.      | is removed and         | rate_limit/cache       |
|     |                  |                       | reapplied.             | remain set or that the |
|     |                  |                       |                        | interface may stay     |
|     |                  |                       |                        | stuck down.            |
+-----+------------------+-----------------------+------------------------+------------------------+
| 3   | otx2_tc.c — otx2 | otx2_mqprio_clear_sw( | Software reports       | TODO: yes (lines       |
|     | _mqprio_down()   | ) runs                | offload inactive while | 1684–1688). User       |
|     |                  | unconditionally even  | some queues retain     | message: yes —         |
|     |                  | when otx2_nix_tm_clea | programmed CIR/PIR —   | netdev_err when        |
|     |                  | r_queue_shaper()      | silent, persistent     | clear_queue_shaper     |
|     |                  | fails partway through | rate limiting; later   | fails, noting some TX  |
|     |                  | the MDQ batch.        | mqprio_up() may shape  | queues may retain      |
|     |                  |                       | with wrong effective   | bandwidth limits.      |
|     |                  |                       | rates.                 |                        |
+-----+------------------+-----------------------+------------------------+------------------------+
| 4   | otx2_tc.c — otx2 | After ndo_open()      | Driver sends mailbox   | TODO: no (for this     |
|     | _mqprio_restart_ | fails, otx2_free_hw_r | messages to clear      | path; separate TODO at |
|     | netdev() error   | esources() frees TX   | shapers on freed       | line 1749 covers live  |
|     | path             | schedulers but        | queues; AF rejects     | reprogramming only).   |
|     |                  | otx2_mqprio_down()    | them, causing spurious | User message: partial  |
|     |                  | still runs because    | firmware errors.       | — netdev_err on        |
|     |                  | netif_running()       |                        | restart failure and on |
|     |                  | remains true          |                        | otx2_mqprio_down()     |
|     |                  | (dev_close skipped).  |                        | failure after restart; |
|     |                  |                       |                        | no message about       |
|     |                  |                       |                        | clearing shapers on    |
|     |                  |                       |                        | already-freed          |
|     |                  |                       |                        | scheduler queues.      |
+-----+------------------+-----------------------+------------------------+------------------------+
| 5   | otx2_tc.c — otx2 | On failed tc qdisc    | Kernel keeps old qdisc | TODO: yes (lines       |
|     | _setup_tc_mqprio | replace, otx2_mqprio_ | but driver uses new or | 1626–1629, 1900–1903,  |
|     | () cleanup / otx | alloc_cache() already | zeroed config — state  | 2088–2095). User       |
|     | 2_teardown_tc_mq | freed the old rate    | desynchronization and  | message: yes — otx2_mq |
|     | prio()           | cache; cleanup sets   | incorrect bandwidth    | prio_replace_failed_ms |
|     |                  | qopt->hw = 0 and      | shaping.               | g() netdev_err +       |
|     |                  | skips HW/cache        |                        | NL_SET_ERR_MSG_MOD; ot |
|     |                  | rollback. Similar     |                        | x2_mqprio_pre_graft_re |
|     |                  | bypass when mqprio_re |                        | ject_msg() netdev_err  |
|     |                  | place_pending is true |                        | on related reject      |
|     |                  | in teardown.          |                        | path.                  |
+-----+------------------+-----------------------+------------------------+------------------------+
