Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577565;
	b=gyO7wS6qeicEkXGLa64snxVsd95z3SuIuBXJzvKvC8fk222fI51Rmfecbi+mtcfQYGOZ
	 eqy8LNxlFiRYEPlC7HyMwCoQtwiy2OB4wXSXJb+kDErzIrxeIjKh1MP1ti6lMBKGNcSe+
	 XT1iWTy/Ulw3wjhtCeMMhVSFUKdOrrkZg0ieGqh4c215upeCljNs4I0xmi6jMtLHO06JQ
	 Pb4EVBfNCd/hZGg7fNqGIlKNhMWOLpTmNNiZWr8FJPY9GcWTA/s0wO5MbVqtUoBicNWra
	 dgo8A/OkYC1iqB3CFNwU4C5SLsnCryR1q6eIMktsF9wn8+ByMdkkFY+lbJhL8nHZ7NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CnBKBq9BS0pHKaW0VW7qMXRlUoXJCke9CfjFX01uzRc=;
	b=z3dkCcxAKHZP3PAJFGDhIveb5qstIag35hDYF2FgXusYsqLw+LeFDgvtyEkcB3EOSw+q
	 Nkw1ILupIhGWQb6dRg1SdLknFjUCe7Zgf55mEG6Ip1zGnLIWfMeOA/b2lGhcXLYfaM9Eb
	 9A4OhjbMVoU22OWGO0Y0kKT3bdVq0sGabqq14ZUYeE9Vb5KDy8s75/fS5+cfHGNdn7ZCY
	 b2mBpFvsVtfJ1AovUxTrIMlSEi0igy53ZkHXT3ZQLCk9GHDXO5jQ6AtDiXPp8LeXaqfA7
	 OoaUZdSJ2lLPBgj/r13EtWw7lGNvsKlW3ChHwCVKNnn0+yjr2TRPQ+4iYQUuXeZmJ8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lf6y78q2;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A32606A330
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34A32606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lf6y78q2
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2f03eeda984so28842145ad.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577564; x=1796182364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CnBKBq9BS0pHKaW0VW7qMXRlUoXJCke9CfjFX01uzRc=;
        b=Lf6y78q2DzCb5eSIYtNHzhLtUlIqPOuIWycfmh4B+AE6YTIGKGaoeM3+mYU52uH+vM
         WaB+R2ji0oYqNH9kJacMDwX8WIRL4ZnTftBsKDN4p251Li7+Ez3aYdfnNAAu8k6hxy67
         8Km6DImr8yUVsh+yEAJJgwAgqH5ydagMRZEbK26mKNfpE9tniqQtw40CO/KVqMYzuo56
         q2IiDF6bXvbNfEOz2pG0X1Nnj1R1Dn6yH+YierlpnOxMxVrC4GItlLKhNKq61LnSicy9
         9rTWI6GuzuZCLgP4h6/Qr0iFKOdom1EEOIYdeP6HKWbPEgtCcRNn7rig1/1I+6rFBb6R
         aEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577564; x=1796182364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CnBKBq9BS0pHKaW0VW7qMXRlUoXJCke9CfjFX01uzRc=;
        b=WA90PcBO6cMpiEkAnwxo6e1OiK7KCyfz4FjqDsX2OjTBReGsbUJYDOkNK5ZySnt4dT
         KhJRZ+atjt2c16lZoCwiUdDoZwGBlJtNglpSy6rqkgDRZUKqayPYo9wg/7mAwpemX6Ee
         lAhCqT3hmkjTX2I7omujINnBT+y1Y2RF1V3tvjIlF3mW4HUKItCVFjy5FzGGTztG7QWt
         pSxRRjOpNhja3u/Xgsvg5Ep7OKoRvAFe/jznRVN0+2yiRCY+7UtjxupgKCJSavmPPOhj
         zAucA3rJv7q6KS0O+0TXaXpWVqVMw7Ci0E+rAR0ADXlWNLooBzRLgDfqFJsAIwKeZZc4
         Dn3w==
X-Gm-Message-State: APuU4Z92Ajt7Q+wiwGkLpBlfZatm6g795qIU0u8nSfsLIjbCa5pXwu/u
	dsHw08PfZuY5EuxID9IFeVI124WvEgFs6xe70J4e5Hk7TaQIUyBJLcROo+fgJ/XB
X-Gm-Gg: AZFdTZdsQZzWNigNUlGNWkxPYCa+i9VstTiGdnj6OkRdntDA442g8kWgDb+fyOir/Y2
	VaWkJyqTjsxmoOhO2zZbMWKkzx107n8kHI0iPYU5OXUkKid9sYng8v6tyrSIZbzvxwlX/DZFab/
	5+7wF1qGlDT5EUtFaY4O+H1p1FbLiQjfiUazHRp0JZfvpOJGSKPTJc2mGlJuQQszgu0r+8LhscD
	5iusj8kirJUUIUVBLd9uic8ekLsLKNOvAMgbDDqzruYrmLmZPI4DBXt/jlHskAFhWQWA26Y15gP
	tE/SQiPIEffV+gv2wi54lVlRW144HFpMIRFLQhKcQ7R/TyvXek/WMmlLgHsqrg4VI8N0XTx1Yxn
	T0L6j4RHdfuqTnjul0GRuuqezU7A8kgIs5+ZVejSyJn9oXgD9U1BtugV2yJNcGGbN3UdBKZHT5l
	D/lCilpTASKHEerjytfiMOtbUTV3CaFW3hmaHFyDcaWux3OCUqvecFvnOberhTBIr5ZKjXBYgGu
	AMuqaHmHDSSvKt56zwKZ2EHN81wCrt65/33difpkmabIrrbJaflPn5ptq9Ilo39ZbIeRm7Zg4ns
	QKzmIoZL8bRZIaqnfbSnerl8ygmpGPsSMkHUYnCpzdUE1Sd13djCMBj0LeyfqKxJSFKHo9WHJbG
	eQ+eXTgJYI2BODDYcim/Ku5kmGZpjW2vD7Jw4QMigfafSiO2hAZ2YJbGbwJGFVynAB8R6xhckyK
	XK
X-Received: by 2002:a17:90b:17cd:b0:3b4:1926:9e9c with SMTP id 98e67ed59e1d1-3b41c8ff562mr15752553a91.30.1795577564399;
        Tue, 24 Nov 2026 19:32:44 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4b0f482bdsm9724581a91.14.2026.11.24.19.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:32:44 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 31/47] bpf: Require CAP_PERFMON to read pinned maps with special fields
Date: Wed, 25 Nov 2026 03:29:22 +0000
Message-ID: <20261125032938.670542-32-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

A read of a pinned map prints values as they are in memory. bpf_timer,
bpf_wq, bpf_list_head and bpf_rb_root are arrays of u64 for BTF and have
addresses. Refuse open() of the file. BPF_OBJ_GET works as before.

Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 50dad8a3936a..eefd1da179c5 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -310,6 +310,11 @@ static int bpffs_map_open(struct inode *inode, struct file *file)
 	struct seq_file *m;
 	int err;
 
+	/* Special fields are printed as they are. Most have addresses. */
+	if (btf_record_has_field(map->record, ~(BPF_SPIN_LOCK | BPF_RES_SPIN_LOCK)) &&
+	    !perfmon_capable())
+		return -EPERM;
+
 	iter = map_iter_alloc(map);
 	if (!iter)
 		return -ENOMEM;
-- 
2.55.0

