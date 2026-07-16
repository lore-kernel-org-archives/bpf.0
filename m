Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDE127587D;
	Thu, 16 Jul 2026 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784183184; cv=none; b=lz85IjyCvkoKu+B914KDYXX2/0v3DoISlhBtoNdFn95SDoMisEqUusAXMhw6duw4pNKHvrizYZjQ8w3CRD8VfY8Qfwz6ZB0Hs4LK9yhZa+LkaUFrGz5pRJCmpYb2oXy1uRWCYz+tWF/64E8PX4sdtFQ4C13lXLBDY+fsKkUT/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784183184; c=relaxed/simple;
	bh=Q6yv337AsEeLkSM5LwtHZ8sipmUBp7y/SHIN2oH8+AE=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=Yu4IZaPWQ0yH7/QxxmyuWyQjt+AX3rQX2eX2isb7ycT4xAzhxP4WYhl0sWVLf4KYijHXTAuFSWbK6Ezgn9tgIlb4p0AZFYKdmfp4+Rm+iReK86276ZNpXZ+FL9c70lQrK1wrzbGpk+55KMGATiUcDg+GTNKm5kfc8HUl+Xqecqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4h132z2qWYz5B100;
	Thu, 16 Jul 2026 14:26:19 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 66G6QB9r083004;
	Thu, 16 Jul 2026 14:26:11 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 16 Jul 2026 14:26:13 +0800 (CST)
X-Zmail-TransId: 2afc6a587985362-b1e1e
X-Mailer: Zmail v1.0
Message-ID: <20260716142613346GZ_NR5Zi4awr3wEReuIMG@zte.com.cn>
In-Reply-To: <acc8805c-2e66-49c9-95be-43ce1c954ee7@linux.dev>
References: 20260716135515586meEuKQ_R48nXmdnpldURM@zte.com.cn,acc8805c-2e66-49c9-95be-43ce1c954ee7@linux.dev
Date: Thu, 16 Jul 2026 14:26:13 +0800 (CST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <leon.hwang@linux.dev>
Cc: <leon.hwang@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <john.fastabend@gmail.com>, <andrii@kernel.org>, <eddyz87@gmail.com>,
        <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
        <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.xin@linux.dev>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBicGYtbmV4dF0gYnBmOnN5c2NhbGw6IExvZyBlcnJvciBjb2RlIG9uIHRyYW1wb2xpbmUgdW5saW5rIGZhaWx1cmU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 66G6QB9r083004
X-TLS: YES
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 16 Jul 2026 14:26:19 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A58798B.000/4h132z2qWYz5B100

> > Well, the crash may happen when the kernel is booting, or too hard to reproduce,
> > in which case, bpftrace does not work.
> 
> 
> Do you enable kernel.panic_on_warn sysctl?
> 
> If it's not enabled, the kernel won't crash, I think.

I'd like to clarify that the panic in our case is not triggered by the WARN itself.
Instead, the real crash is a use‑after‑free (UAF) that happens when one CPU is
executing a trampoline while another CPU is concurrently freeing it. This results
in an illegal instruction (or page fault) at the PC, which is fatal and will panic
the kernel regardless of panic_on_warn – because it's an Oops with Fatal exception
in interrupt.
