Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2082EBBA1
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 00:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772758279; cv=none; b=QXnbrvgIaLEN8MWT1Mw9Nd+4Pux59XmdXt5C8u6K4UPutlV16d9aZjpEfCBeEIsOQsrEfkhvEh94bjDZDPnjMM1azoI5aznd8DVAXk/A9UO10Z95TeWmFyb6BiyQjP9lNdtAm1afLXTCDEFEj2NBC3H3NItnRJcOowKbXuCy+I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772758279; c=relaxed/simple;
	bh=3dlLQAlasBGbadIvHX9k8flSJPAsD29x0afq21FmLvg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SntsaBiHEeGMZE7bdqnKaRc2tCuMA+9+4E9dBHNmQ/xqojFJOFCtYptjCOpGp1qaRJrR6S5GaiFxye5fntGJ+jPg35xKBO8CIfQQsk7C573/5JUW2qsRf8Vnx3uOm3dwHfdnEaTzPzof/46k3qhgtDRnphQydJ729yxUEjbg4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BxRq4x+7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BxRq4x+7"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48069a48629so90459955e9.0
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 16:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772758275; x=1773363075; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HfzwmS6sVtR8qdJxrV1EFi7Ums5fv3yYhTk59aaWPfk=;
        b=BxRq4x+7iY5HrEz5E1oYjZAXM5BCZB3+BqNSZPC5Uc4QBoOfh0ZLaJi7j3nVI9U69J
         TzJkFQlr1fkdKZtRW+QECw/tIBCkDnhaYM1wvZ6tH7qnfsdRDXoCtGS5BvoHM3VoiR1g
         VPtkZ4M+T8myVSIgKsjDJQDnNK1OC9Xbza0LNwQbJZHwwpTQNfjdjpjrr4r3bYlw+2Rj
         Yb07aA7TtvJbKNl2FqORAPLU+ernZ1/21V2103QEhKl75xG3kmiPOmoSa+3UcyO6lqGU
         0AOvZTuQFEuEbGxwjegqea44kH8hiyolb6WidlJVyLLRRl+nnRHvDRqnPgiHhKCEoyCT
         gK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772758275; x=1773363075;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfzwmS6sVtR8qdJxrV1EFi7Ums5fv3yYhTk59aaWPfk=;
        b=vwdPBxN+DYv3ovh7FquoaZbzpbqmsF0o7P0qL2Qb+ftxJqT827Avb5+NprCePM8ykw
         bf6AhkTt3Qm3hHGIHNFfBox9shPp0dj7XWFt/Tn3d7LKLwgcKvWXNWhayc3g+XBjw63w
         qY+QmFqL87lzEcHu+RgBvLPrXv/y09yilX9qDjiAxAzhmeJ9SLQiVwyq/lFmDbICi0Bp
         WVLo3U5eg5ydgFFEJCfIYejQtDyMSA+tvp2RisrfACVda7cJB65JgCEAceyAhmAi/ht6
         GxxhCuMKcWRPz4437C/r9hIA6yUaqFHlvmX4pEPZ/ZzcmRyhJsBTBvFgpEqEep/SDZqe
         PPQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIYlONHQ3q8AsH/tEgwYIeaXDbslcsIO6ISqS0m3inTwHgdtcplmUjzDFBNN8aPQOrozs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzt5SnECsClKTH7CMxHuseqLyAp8BSLohE2G48fQQqwevoEIwP
	7RmwUADexXC39uNE73oe5aT2+5vPdVYdXZsNzmwQ4PrRf/tPUjz2MPiSlVqjShlTMXQ=
X-Gm-Gg: ATEYQzz5gNWGlzYywCjqavcw2hcUKijlaMPg5QVOt2fd4WhTwRdrRIit/RC3Sv8/6Af
	zofnaRwMrOe6b9BapLRNVVgpennR1meAUlMMK5z/wrlN2mq71/6Xa6ZobaxAJg0+9RuZSAc09kw
	lfK+E3bgUAC+ncofjrIuU/hrHoTkApPDEYwVI63HicUEMEF/RWZ7XTyMgENZlHcNd0wzDR2yMya
	hHpfsw1nxRmd58dB47DZhUyXxPy9E17nK6FcZAedn4NhOC3xw9jazCGg2yQhI764QhWccFnzZwC
	4GEmsiyaf/0oHfjm+FJ5BY8bEByNlmeFNIB2X5A/PhHJIokKxcGmTptMUYEhErxXSbdcHI7MeXj
	5EqYpHRTgIhgNSEpkljaxU5NkI2XGRpiqaAhqbB3vIelbFmT0Fr0R76x+S8ZoGTFbVUx55SExcQ
	UYhuAvIWhyjVXevsXwQlrd
X-Received: by 2002:a05:600c:c8f:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-4852695aec4mr2898715e9.18.1772758275517;
        Thu, 05 Mar 2026 16:51:15 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffe82e4dc5sm6259137.0.2026.03.05.16.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:51:15 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Subject: [PATCH net v3 0/3] {net,bpf}: nd_tbl fixes for when ipv6.disable=1
Date: Thu, 05 Mar 2026 18:29:54 -0300
Message-Id: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANL1qWkC/3WOwQ7CIBBEf6XhLApbtdaT/2FMw8JiSSw1UImm6
 b9Le9GDHmd23s6MLFJwFNmxGFmg5KLrfRblqmC6Vf5K3JmsGQjYC4AD9zRwb5oBb411T4pc00F
 qJUmgBZaxe6DlkKkzy2l2ySaqSByD8rqdv2V70ynn53zr4tCH17IgyYX6X5YkFxwQFFRbY2vEU
 3xEWuu+W2oSfPhS7H7wkHmsZFUZlKq25Rc/TdMbMpF1Nw8BAAA=
X-Change-ID: 20260228-net-nd_tbl_fixes-ce81ca1e0bf2
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, 
 David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu <liuhangbin@gmail.com>
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1772758271; l=952;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=3dlLQAlasBGbadIvHX9k8flSJPAsD29x0afq21FmLvg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM1TgpuypqguctN+xKfI46/kRMYE9SzBsWbPhuzyij0XFje/ujCBxrTCHF6tCJnA1lxc1tc3gCY
 jK7IWjxASLgQ=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
Changes in v3:
- Don't use ipv6_mod_enabled() in net/core/filter.c.
- Link to v2: https://lore.kernel.org/r/20260305-net-nd_tbl_fixes-v2-0-b7177db1a9f3@suse.com

Changes in v2:
- Used ipv6_mod_enabled() helper, guarded by unlikely().
- Link to v1: https://lore.kernel.org/r/20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com

---
Ricardo B. Marlière (3):
      bpf: bpf_out_neigh_v4: Fix nd_tbl NULL dereference when IPv6 is disabled
      bpf: bpf_out_neigh_v6: Fix nd_tbl NULL dereference when IPv6 is disabled
      net: bonding: Fix nd_tbl NULL dereference when IPv6 is disabled

 drivers/net/bonding/bond_main.c | 3 +++
 net/core/filter.c               | 7 +++++++
 2 files changed, 10 insertions(+)
---
base-commit: b824c3e16c1904bf80df489e293d1e3cbf98896d
change-id: 20260228-net-nd_tbl_fixes-ce81ca1e0bf2

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>

