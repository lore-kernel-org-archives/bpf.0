Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851BB4A13AF
	for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300812; cv=none; b=GanjSHTaDHL9WTsZQJWiCUEpqotjRU2Gopu766cSwlbYsvIDy36pxjTgP2ez7iib5QnQ5/AsbQ7kXPGqkIQ33vz1O0NLJC3hX9RPBlzcDwUDMxp+rLas4p5p5iGzzLpuUirqhxYTGEn6P8weT7+MtEzxDHLmPoQwloeWswLGqPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300812; c=relaxed/simple;
	bh=dlKdIuS6xnavxo8NXhJsDvvrNxnPlWn/ak3wdXheDj4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=H+CF+iot++DIIW86waQOLOKWJqmvZ8OZyTBpIWPqt21ZeyDsRGs8UNKnCFwkDDptU49uEnTvW/Fyr048uKE/Ntakf+dLolB6/7Ha4Kx2an+tXMW7fGKq8Pf9/KacATMnuaGalnOxEXX9gGiUdje56Y2h+cfw1n0fBYecx1F74eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D+gZfHnI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D+gZfHnI"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso26790675e9.2
        for <bpf@vger.kernel.org>; Sat, 28 Feb 2026 09:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772300808; x=1772905608; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9iT473GaNSiBNvy704xGRv3NDVuBZ8HLXblvauGdhRo=;
        b=D+gZfHnITIYzVpBJmg3Fcx+mXA97FUb3sTTpKHeK8ZbIrHtY/YnhS+udvwIr+S0Y3w
         2UTBSczWl1twoRZYMPgI5q9FA+kDYuSGDFgyL23BWZziQ5nB6bFnKkFR1jjMBKg9dTy3
         Z5Qlhj7rghVggjO/pTkVmujWAmKw2jLt/VMKIERG5qT1vvTmNp0Zqm6OfYntwghzB8mv
         Qa0QxhaEdwzahPMvOqdblOZTl/bNEj32kOq0F+eI5R79ndgFIeqkJv6d7cw3nhdPvn5Z
         rEaS6sc6I1qcBpG6HDfzN95cCyXSaZE57Tlha22h9urjAaNnZDPeTQ+SSru+Oesh2J4w
         YmDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772300808; x=1772905608;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iT473GaNSiBNvy704xGRv3NDVuBZ8HLXblvauGdhRo=;
        b=fkI4dsCrdW8OQcNa+k2e12I/d/wllDm0GRtyorJXB0dRvU0TFT5a3pYNoIknvDqGeC
         NVYpfyntVaZm6IEUOZK9F/WlcwWLza8i9+upvoRsOg63g228hIiAj+pL1sj7nbQURiz9
         tHwyBuTRSyqSKHM5X7X8Snrp5NIvrCqrt2HIN5c4+ss23O9CWaVhku8l0lsEg1Lkviwm
         3o4ScJkhO0OuUrZwhG5p2ovErektdj20obBkk5AL+D8mL6GYqqZsfr81/yN92pUbztB5
         aFYApfIkmGySI1losGB2RXtC0a6Q+2WqEqiUY9OJJW2ilLQYX3PxLmOSK8hKqJuxPe6z
         wrcg==
X-Forwarded-Encrypted: i=1; AJvYcCX352JKIyYhjsx0kAm/PaEZV7SbIi4zvi2jdTZYnCtUNNgm5sCahxp0JWD/zuUTSMcI/Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkH7LP/YEHQFMQ5yEFik31ZTeHQV5pG/MUJGgdX+A68yTmXJhC
	8KMi+TNtvXXUCemlnPyL5w9AvIt8RAVKY+IliHnVCltsaVpj/ZW3Ec46mgE1fPvOmBA=
X-Gm-Gg: ATEYQzwzWZVuHVXwkGWG9shkr/lxVSpX9o07g6cAJaNMk0V5vU+LT3YU9Tve97aDHIF
	jxnWtF7daDjMBueAAIzndI+AaiGUCv1cHjKi6rshFRjKcMzeyLBIjP89d409kfQdpD7Uo/eLRyV
	FEu0wbOGFDVE/pYx9YP16cq6bJ2ORvcFe518L5ThEH6bWiwvWWiH8hhKUoslq8IQTYt6tt4TTAN
	2FOuR4l8jfNPgDU5mZfZt0xw8phtsCCYxSUc8Gk6qBXObKb4jFCC6KvwleBoWjKDmUFDiicxDP5
	7Ryv24wzUbPogzYGQiZd8QENe/TCd0vvA1CX7cUEmes72kQhtKvvzufuRT1srcDyViaBLiqcADr
	MxbUPrifvd6ekF/tjSbi4PULROVJbM5QGWHI2q9PjeHh5c7JxDoRTs1IrgEN0Do4xnULc+CjGGG
	AN5cvMa7Mb
X-Received: by 2002:a05:600c:8106:b0:47e:e8de:7420 with SMTP id 5b1f17b1804b1-483c9c1d4bamr114327185e9.22.1772300807882;
        Sat, 28 Feb 2026 09:46:47 -0800 (PST)
Received: from localhost ([189.99.238.12])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a91bbd85csm10470908e0c.7.2026.02.28.09.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 09:46:45 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Subject: [PATCH net 0/3] {net,bpf}: nd_tbl fixes for when ipv6.disable=1
Date: Sat, 28 Feb 2026 14:46:25 -0300
Message-Id: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPEpo2kC/x2MwQrCQAxEf6XkbHA3h1L8FZGS3aY2oFE2RYTSf
 zf2OG/mzQYuTcXh0m3Q5KOuL4uQTx3Uhe0uqFNkoER9IhrQZEWbxrU8xlm/4lhlyJWzpDIThPZ
 uchRhXSHWcAtY2AVLY6vL/y3w+clqsO8/UCMlM4IAAAA=
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772300803; l=871;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=dlKdIuS6xnavxo8NXhJsDvvrNxnPlWn/ak3wdXheDj4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QB5t23466LDdlWe6GOU3Ku7w2y7zVm4BReIL50g45VmBStweYPysdCxLRqjdUXULpUemO9qKrNW
 llnNqSeZvsQQ=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Hi,

In line with [1] [2], I'm sending these small fixes for similar crashes.

Thanks,
-	Ricardo.

[1] https://lore.kernel.org/netdev/20260227112701.3990-1-fmancera@suse.de
[2] https://lore.kernel.org/netdev/20260226234059.19402-1-fmancera@suse.de

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
Ricardo B. Marlière (3):
      bpf: bpf_out_neigh_v4: Fix nd_tbl NULL dereference when IPv6 is disabled
      bpf: bpf_out_neigh_v6: Fix nd_tbl NULL dereference when IPv6 is disabled
      net: bonding: Fix nd_tbl NULL dereference when IPv6 is disabled

 drivers/net/bonding/bond_main.c | 4 ++++
 net/core/filter.c               | 7 +++++++
 2 files changed, 11 insertions(+)
---
base-commit: dabffd08545ffa1d7183bc45e387860984025291
change-id: 20260228-net-nd_tbl_fixes-ce81ca1e0bf2

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>

