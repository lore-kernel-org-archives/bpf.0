Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860A3112A5
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 13:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769434470; cv=none; b=ON8h6j0qRezee3dcS0bEqU/LfBMWTmcQ3TIoeFA1Try4T2/i965Oy2HF/FDuDTzk965/v5HnszV+Bd0rrpJs+8BDSAyDT6Vg74Cek8T32o1pdsd2EOCd9Bmee6JN+62lYV3gCXIi0VGekYgETyLhdbSAwWIkNHnMdda2lAtsRYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769434470; c=relaxed/simple;
	bh=f53timH0np4bz+gztyV/dfAq6Ha3g4qBItMHfYuFoN4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lGP1pnZRQ+bWxDBUQcgnyfnEU/LG7tx2oS1gqV8mly4cHGXyPbk7quhfw+21+koJSlYuePBTpCLGFrJDuvGsTmDvHLoqmP9hlf179hLbmzCZfS9SmYJJAvys3+sAJqtRZqCrlEhjonOHtIfpSTGnor9L/hViB4MGzWnsQU/HegM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpeAceir; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpeAceir"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c53421cdbfso553024385a.0
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 05:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769434468; x=1770039268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQxwi2pFUZR+UAlToTQBrAAHIAjqCBSvDHQE8e6QSYI=;
        b=BpeAceirIB3MafojmiIC4MtwwBsxINPhSrZWWX+7ErMsX5ep4n2ZPvRn86xJsbivLv
         gXF5PJLCX8ZoPbjF3Vx27CXvGLQDnlwiFj9uFgDR8KLzZm/ZULVzscsFhg23SmGy0F1J
         uw4t53M4VcXNA4E1SH7C8Kq3VUUMBpH6Q8KlgWszh7fSiNcR7gzsS7887/gVaYV1gfwU
         jP6l4N3YDg+g2JALwXRP+p3DI0Vz9eq9lji5z8WdQREZiD8HjlpjJyc4j73+uBogGNe2
         2g2SnzkNxTYa+P0rJpNTbPNBvgpEK8gbea74QdE84mHO5HNdx0gdZLt30LZdY0cRR/8F
         eeXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769434468; x=1770039268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iQxwi2pFUZR+UAlToTQBrAAHIAjqCBSvDHQE8e6QSYI=;
        b=tryRd1V7qJ8ajxw3BJ98AWi4vm9EFqo7tJFbD9mcvnt4VeRij3VB6CiPVBNlm247zB
         uFF4dTlIGKyWOscfKiSKkyA9VDe5v2/cqZkY6Tm7vuuKer2BPm7VVQ43H6F0ryKvjKBG
         Tr0nSjN5o0MMVxDyWZdjZanzNc8SXEC5hxfwb/VhhCfqccUxOaal+0TT8sBPJO6JJLuN
         +/M8iqeb/esDMty4ijuLpis/H6r7usB8HAWvpt3GlO8lQJQGnuZ1aq84p93DntQYmSTU
         jdn5QNgKTqYNbvGNEqyldx56NHgFMk6zO2UW2dPlqeSL5j2iCDD6nEATicHSl3I3rxlU
         9u6A==
X-Forwarded-Encrypted: i=1; AJvYcCXLisOfmrUqrWbG/pwMtYlX4It4hfCHtk4KmUjtuymNDfIIqCsiN/Qg7Ile+XwWG/8IJpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2vxHD25SifDtYGgP/5HAGv9NEfDOXxFR/+5g2sk95+LE4+qBt
	c/Jsm4T8DAw3cpBikACpMMEuCpv5P0YFZHX6YOQVsV32vmGF8fqGeEA4
X-Gm-Gg: AZuq6aItaC4tnC9pYG4vijX9oodsoaWf+F2EI4BP3ilh+mNJwZLkZHVY7RIeu2JknZV
	lj5tMWOO/8BBSsRvtSupwPoyU2sk7J/iSsYlANazUli1JGVg0LuFqjoryzJm0t4sHfd+b6UXZ7x
	JrIDhNxx2ZnujbTdVb4Io3P84r/QLU3Qc6l0YKKluDagC7KGfEF5UBeLI6da+dEyDXWqrgy/jDD
	LsuHBc8Ck1nBB23Jf0KjOoRHl2hiasNiPal3ifuJjf75A76d1MxdFfhS+Cw/98WDom1178TYqQk
	jEpFsL1cJnoZpb5HBwm5IZ531PX0PnA2K9O/PdGAY5DR3xqqS6pM0C1TnPOGLq0Osy/QwM002/i
	GGEdFum7k6SjA30t39uGli/OmA8W2uLktg59pwMv8loPrV+qr5XLEDQEYdaZ1Tz45mE/n4SrytU
	0nkltGJx78mnA3Ty+ZtVg=
X-Received: by 2002:a05:6a00:22d3:b0:81f:4c37:7647 with SMTP id d2e1a72fcca58-823412dbea7mr4104835b3a.68.1769427926560;
        Mon, 26 Jan 2026 03:45:26 -0800 (PST)
Received: from soham-laptop.. ([103.182.158.109])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82318648dd7sm9086663b3a.3.2026.01.26.03.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 03:45:26 -0800 (PST)
From: Soham Metha <sohammetha01@gmail.com>
To: linux-kernel-mentees@lists.linuxfoundation.org
Cc: shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	martin.lau@linux.dev,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev,
	Soham Metha <sohammetha01@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jason Xing <kernelxing@tencent.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Michal Luczaj <mhal@rbox.co>,
	Mina Almasry <almasrymina@google.com>,
	Eric Biggers <ebiggers@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2] net: skbuff: fix uninitialized memory use in pskb_expand_head()
Date: Mon, 26 Jan 2026 17:13:30 +0530
Message-Id: <20260126114332.23955-1-sohammetha01@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6954bc70.050a0220.a1b6.0310.GAE@google.com>
References: <6954bc70.050a0220.a1b6.0310.GAE@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pskb_expand_head() allocates a new skb data buffer using
kmalloc_reserve(), which does not initialize memory. skb helpers may
later copy or move padding bytes from the buffer.

Initialize the newly allocated skb buffer to avoid propagating
uninitialized memory.

Reported-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=619b9ef527f510a57cfc
Tested-by: syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com
Signed-off-by: Soham Metha <sohammetha01@gmail.com>
---

v2:
- No code changes
- Resent to netdev list
- Added Closes tag
- Added Tested-by tag

 net/core/skbuff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a56133902c0d..b0f0d3a0310b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2282,6 +2282,9 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	data = kmalloc_reserve(&size, gfp_mask, NUMA_NO_NODE, NULL);
 	if (!data)
 		goto nodata;
+
+	memset(data, 0, size);
+
 	size = SKB_WITH_OVERHEAD(size);
 
 	/* Copy only real data... and, alas, header. This should be
-- 
2.34.1

