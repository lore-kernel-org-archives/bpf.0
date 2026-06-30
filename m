Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79F71FCFFC;
	Tue, 30 Jun 2026 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782807329; cv=none; b=lFOZ01aIIS0uwLBuU3C6MgmEu9ConLZqHkj3BTM6zxoYO/LzdrQ/s1DytWeuhkAKOrfcD2UUhmzXhAvgUmJmog89DjQ1hV4E6OXMZym5BcpfRsaXkOeIzBB7+8beFkdI4q/A3c1fK9szi0ixZ1P+1zrt8DK81utvMR8gfW2QEQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782807329; c=relaxed/simple;
	bh=2FO3GFdlx/35mYp7J1ehhVKATK9d3NfbW/2C6l9aeMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pS8d81T0ggTBsFKSAdAs8ItN3JvOJIVM2LJiwSTJBkjThB7GBibMy3pk63Zu/jY9KNujSpYCIKmKMKq6p3SyXVgD8W5QtYK3XHTOlF8qfXhgoV7EBOe9+P3WhpZnLByjPANW/qldPzX2/3NdUdc3kBnqkt2QJdJnJF5KjCQBs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d4a7c302745b11f1aa26b74ffac11d73-20260630
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:21ed812c-ddb2-4ac6-a199-c2c63d0cb047,IP:0,U
	RL:0,TC:0,Content:13,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:13
X-CID-META: VersionHash:e7bac3a,CLOUDID:9e5185e0d9ad5dd29d1b815af61615ac,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|123|850|865|898,TC:nil,C
	ontent:3|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d4a7c302745b11f1aa26b74ffac11d73-20260630
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 611008674; Tue, 30 Jun 2026 16:15:18 +0800
From: luoliang@kylinos.cn
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Liang Luo <luoliang@kylinos.cn>
Subject: Re: [PATCH] tools/sched_ext: use btf_vlen() helper in compat.h
Date: Tue, 30 Jun 2026 16:15:07 +0800
Message-Id: <20260630081507.3078867-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <akNQjzejJOdtDYnQ@gpd4>
References: <20260630031246.2618216-1-luoliang@kylinos.cn> <20260630032027.92BB51F000E9@smtp.kernel.org> <akNQjzejJOdtDYnQ@gpd4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

On Tue, Jun 30, 2026 at 07:13:51AM +0200, Andrea Righi wrote:
> btf_vlen() currently returns __u32, not __u16. This changed in commit
> cacd6729c0923 ("libbpf: Adjust btf_vlen() to return a __u32"), because BTF vlen
> was expanded to 24 bits. We should update the description to match this. And i
> should be changed to __u32 for consistency.
>
> With these changes:
>
> Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks Andrea, and thanks to Sashiko for catching this first. You're
both right, and I apologize for the noise on the list.

I made a basic mistake: I developed and verified v1 against a v7.1
baseline, where btf_vlen() still returns __u16 and the warning does
go away there. But I did not re-check against current mainline,
which is what the patch actually targets. On mainline, cacd6729c0923
already widened btf_vlen() to __u32 (the BTF vlen field itself was
expanded from 16 to 24 bits), so on mainline v1 does not silence the
warning, and the commit message's core claim is false there. Sashiko
flagged the return-type discrepancy, and Andrea identified both the
root cause and the fix (declare the loop counters as __u32). I
should have caught this myself before sending.

v2 incoming, rebased on v7.2-rc1, with the description corrected and
the two loop counters declared as __u32 so the comparison is a plain
'__u32 < __u32'. Verified on v7.2-rc1 that all -Wsign-compare
instances from compat.h are gone across the 8 userspace schedulers,
with no new warnings introduced.

Sorry again for the extra review cycles, and thanks for the careful
reviews.

Thanks,
Liang
