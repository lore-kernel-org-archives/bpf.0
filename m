Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6151A3A80;
	Mon, 12 Oct 2026 03:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791775263; cv=none; b=GGpDu2qYnAwMk4impvhhNhQvIxNMILTosqs+qkjVBZf5fqXRkM9Dpo4PMt9Eb3Ru9JY5ZigQJSsKkNJ13SoqwjCW2XNVwrRaZx2s9XqFLQkTcftUQm5bBdVTn1EV7E1SAHUL2V9u4s67QR6O4s9OF9s7Yw0tWUrlte+0Nm1Mtx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791775263; c=relaxed/simple;
	bh=KwpgVnpGdC5F/8qIEPC9K0OWtLHsuEgjTSiknpzoVik=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pe6wT0qdVvZPXgSwpumBcknp71/QWqMCMjkH8eI48OmZm2viSOWQ2MrA8S1EF/t43hWg0zOKONFxv0hsC6Qh11tRmAd9Jb1dpSkcvK/9uXuWbTbZkmTV2KgJyoQyzF8BkM/C3K0uXDJjH3tyw5z/s0PWVCvEKvq7s0YLX+3JqM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=dWkw1gu1; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="dWkw1gu1"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C1mXM31577111;
	Sun, 11 Oct 2026 20:20:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=9
	krnAw2hTJAN3iKwESbkRnnmpNs0d5MA3n9lfMTX5p0=; b=dWkw1gu1eRmR0i++t
	LMkNTE0C0TcGzd8sGlclgYubf2WUjGRXeSliRkI49LXJdV9mcA3BtHH6BNiCX3si
	ou5lQ6hCuK3qjmLT9ZUoxhN6LF+Xb4nfaCxyv3xUBVOe8yjCh74ekKmbjE0XnjFf
	lqKiSa3X8nF8dWb9rbnvbO3MbVVkXQGBfX17fffTl4Ob5aQ2Nm1FAXGL3gham3iA
	AQAPN6kTJI6wybqyk5yAEBO4T8bitUUIsoNnRTVCL3Yke6/3i3eWfQjLPsKqAQft
	2TMGZYG0Rm/ISVKt+C8HW6brwOsSvZ/2aIPIWM1qxWZwrPPERQzsF81ONe8Vykeb
	mKX/w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4h8647t7gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Oct 2026 20:20:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 11 Oct 2026 20:20:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 11 Oct 2026 20:20:21 -0700
Received: from rkannoth-OptiPlex-7090 (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 0C9253F7061;
	Sun, 11 Oct 2026 20:20:16 -0700 (PDT)
Date: Mon, 12 Oct 2026 08:50:10 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>, <edumazet@kernel.org>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sdf@fomichev.me>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 1/2] octeontx2: use atomic bitops for PF/VF
 and rep flags
Message-ID: <asxR6rpmf9b2by4O@rkannoth-OptiPlex-7090>
References: <20261006094357.840823-2-rkannoth@marvell.com>
 <179162646892.434549.7222119532595039059@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179162646892.434549.7222119532595039059@kernel.org>
X-Proofpoint-GUID: V7F2jhYx1d0ZJ7g4ziOzwkZnydgJGosz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxMiBTYWx0ZWRfX4rkP4xI3ndF1
 1/2joZ61ZK/HNmSmxT5rB9sT1krayzoSQHSS77xeLSC+IUjPsGZ49AA38McVZmqNzbFWERP9Jw8
 qEvXWiez+O+Qt0ba8TfiKAnrEt4u1x93aCn3lMpnF20Jf+Ji4O6dFVTS4gG+YXm9bVxDBBAcJt8
 XmrH5flXRI+NDHEWLUDGKnZk74YU9xjDe4mq/Fs0Vwx0CXCV/W/TchdR2R1C6ggkn6TNpnJk6gi
 OCY8GPzEIN0RxJll9GXz52SyLo6ks+ETsSTjw0kULtGmZNAknep7lGDqcQxRKVdJTLBQVtytq7I
 dNHj0ZlczsLOU1qzoKqQ4sByA/XHLQAYemVUIZdMkkbSf3zZ2qwY9O6LOokVmzF5ghETUQSmJ2Z
 YYIwxLd2hC8DIx/rviCS7ktrTH18PfSAGquSdatj6fTtuNZRnXzAulyHSR72IfZzNf+AXaynrsf
 D4mpGhVS5vECgqAq9vw==
X-Authority-Analysis: v=2.4 cv=MOD1C8Zl c=1 sm=1 tr=0 ts=6acc51f6 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8
 a=EAnwtCU2dz7jGvP1txAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=lhd_8Stf4_Oa5sg58ivl:22
X-Proofpoint-ORIG-GUID: V7F2jhYx1d0ZJ7g4ziOzwkZnydgJGosz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxMiBTYWx0ZWRfX9GWuTHGqzdM0
 6xJQp68679jgJhyP6Fxdt8ek/VSoMDzVJAmWGh6dZ7fvJabIutBXR7pXr2xigjHtuzFHQB9mixt
 I2QCpWlp+xKmrF/UmiaYUmZaNYCkbPY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01

On 2026-10-10 at 15:31:08, netdev-bot+sashiko@kernel.org (netdev-bot+sashiko@kernel.org) wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 · High: 1 (3) · Medium: 1 (5) · Low: 0 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [High] otx2_sync_flags_from_rep() (otx2_common.h:625-634) updates the
>   shared priv->flags word with a plain read-modify-write:…
Pre-exisisting issues.

> - [Medium] The commit message presents this as a cleanup to atomic
>   bitops, but the patch also fixes a user-visible representor bug and…
This is side effect of the fix, not intended one.
