Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D61270EC1
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 20:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772916666; cv=none; b=tV3z6m9iDKTVjy1JAmGv9q+SHi4WzgzqyNLLg00i3xczgoZ2nyq4DH97LCpoNj3JlTfksOM1/u2+GP/VzayAJf/Is0YMIrjAYwzDHueTqCyWNX3OJ9yMol6YHkNsT92JzLYt/FFKWAQOWZgK/l6sXZldwzTpwI78eHBwabbwgMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772916666; c=relaxed/simple;
	bh=6haq1LWJ2rMn7CiJy1QtMn8Y0nk+PfGJ1NB51Njj8RA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O7bJKpllpLXkEb4kkZlSwjd8hrr0G1QYypXnM7z3s4PCn4jVrikT04eWmV5KjYiZJ93/3YclR9MYevrLzBtZH8KcZffUptK3vTWdyFS44ESjbRWVtpaleA0ZbN6bFlal6X8T6+3TK16qRWGhqVbL9ycGmhFzbQKjr69/0OsSo/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J45mcSAG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J45mcSAG"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48529c325f0so10068685e9.0
        for <bpf@vger.kernel.org>; Sat, 07 Mar 2026 12:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772916663; x=1773521463; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPwZwL7GcnfzeMamXMXXY3ZrtK1m1z2a4hvbEHv5oJ0=;
        b=J45mcSAGuZ95PpPbAN4d+u02Z4TS46ldcq73TKkNP6XTBeFRvEewGaUqRKctWfmFOW
         THsf9w+A3+Lc6y1EQYmaXHjorqct+z7WJsW2aB4GDEMRa0mODYH9M1LC4rZ1e7jA6/0H
         hu/9Km3yL+G/7bUySh4anVw1QzfuQtvFSeOatdH7vnIsa9B7Lg33kkOg4fQs1BzCtPQQ
         QXy8tclelv/cBeAMQrBEvqcXWPGh408ntegTe8FvLN4444iXspU57af6nyn+Olp0wSWL
         yBb2os0l7gvlzux4+UWBn/M7P36rBFLhpAoHZ+LhxW6U3KvFSsaEoFtKgxCrnO6Lc5Lj
         DIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772916663; x=1773521463;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPwZwL7GcnfzeMamXMXXY3ZrtK1m1z2a4hvbEHv5oJ0=;
        b=OGixPQ/CCMzjO0u47j29VAELP5FW0ydZ0nZI9+S+HDjwaiALMRfWg0shgmXp8D1T0b
         zmp+Ue4IHdwec6wA9wg6nJbgteY1HJRHdeXEpED9dn/56uHW7BrCmiFwnn2XLvlq94hm
         0OmjpBd5iG0uBn6bAa2Kvkj7OrbQYVOPquJwrhYftudSrq4QaBU3k+Ip34vJcnI0da9A
         jOG9aGVNfAo1RI2k0NrJ+Dgo1EvXO/grYc7QzTmdQZeZ17YlouuPBf/eZg88cgs0WJrQ
         W2PF0lTgEGYponX2AXOWe4MR1/mdSpM6Ogzp3w2SoMmUazHkUoNSKRUomMJqYG4X37dr
         hQ0g==
X-Forwarded-Encrypted: i=1; AJvYcCXylRy0PLigDi6aLdAiDXd42QmVdzu/BmmLQ3t5RkJX6puxWMJQivyqvMkdtHbroFJgz2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYCM5vS/x5zAZ/OqTBqp1YbV251P2rEDdEQ33wDBwIwoVUi1M9
	hWL8HZC52KdeoCVMAlJgrFThzQh1Nw09f0Vnn62h/hGosGeCGe8TBWIWEr0yd3ie9kk=
X-Gm-Gg: ATEYQzxK7WbgcMIyEt8okS3tK6F5AWbhc7seNtrgYuk97oAT88pj5hobog/2W+WwpuF
	QqtMYrEBmML5DTnGoiFOTgMY4fdaDKCRFcSVP5XoddrIn2c2lZCjNXxiJqvGNB7lIO92jLFzwvG
	U0quC4FTlM+E6SImGoQ6qhtBerSpH5dVzdJ88qb2n+0F5PN0Q5JQpyDdw/6DX7ZkgVpVZU/HhEA
	nuDcsfXrss30tvMX5G1zZ6wwDbc5gUF6h+9JBqX4GwNuD05Z4qvzSsPTbtNqTiNnGHNL1zOa0vz
	rHGK+HCfhXjacovtbDwGs1vCFAbThG1BVZWmzVqMQH6+gYl0NZQmi41gO1j6IeE8N2yq2lycR3Q
	hOKxH66uGmoKkxFEteQlYeyTrrKkMyJpMRgZHApIOd6m0VTfdQPk+4PRTekzUA0/KLNtNmNU+k8
	o2bUmwxKgNfafjnXjRn3Kj
X-Received: by 2002:a05:600c:19cb:b0:480:6c75:ddce with SMTP id 5b1f17b1804b1-485269791a9mr100153655e9.33.1772916662911;
        Sat, 07 Mar 2026 12:51:02 -0800 (PST)
Received: from localhost ([189.99.238.164])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b09a2614fsm6038280e0c.7.2026.03.07.12.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 12:51:01 -0800 (PST)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Subject: [PATCH net v4 0/4] {net,bpf}: nd_tbl fixes for when ipv6.disable=1
Date: Sat, 07 Mar 2026 17:50:52 -0300
Message-Id: <20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKyPrGkC/4XOwW7CMAwG4FdBORNInLIUTrzHNKE4cWgkSFFSq
 k2o747pBYQ27ejf/mzfRKWSqIrd4iYKjammPnPRLBfCdy4fSabAtQAFHwqglZkGmcNhwNMhpm+
 q0lOrvdOkMIJgdik0N1h9Cp4WXxyiqySxuOy7xzaO12eX8mO+S3Xoy8/8wahn9fexUUslAcGBb
 ULcIu7rtdLK9+f5zAhPb9TmFw/s0WprA2q3jebNm/+8YR8DQYtGOds0L36apjvNlP65TwEAAA=
 =
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1772916658; l=1847;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=6haq1LWJ2rMn7CiJy1QtMn8Y0nk+PfGJ1NB51Njj8RA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QB5/qXUWK/NVELUIPP/zT+sFffR8F4SCUOdH+0tDnm9TxNZJ2GXSV7qA4OQUWERJEgdBNLxu1a9
 GXK8EFF6QKQM=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Hi,

Please consider merging these four patches to fix three crashes that were
found after this report:

https://lore.kernel.org/all/CAHXs0ORzd62QOG-Fttqa2Cx_A_VFp=utE2H2VTX5nqfgs7LDxQ@mail.gmail.com

The first patch from Jakub Kicinski is a preparation in order to enable
the use ipv6_mod_enabled() even when CONFIG_IPV6=n.

Thank you,
-	Ricardo.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
Changes in v4:
- Use preparatory patch from Jakub (thx!)
- Use ipv6_mod_enabled() helper in all three patches
- bonding: Move check to an earlier point - bond_rcv_validate() instead of bond_na_rcv()
- Link to v3: https://lore.kernel.org/r/20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com

Changes in v3:
- Don't use ipv6_mod_enabled() in net/core/filter.c.
- Link to v2: https://lore.kernel.org/r/20260305-net-nd_tbl_fixes-v2-0-b7177db1a9f3@suse.com

Changes in v2:
- Used ipv6_mod_enabled() helper, guarded by unlikely().
- Link to v1: https://lore.kernel.org/r/20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com

---
Jakub Kicinski (1):
      ipv6: move the disable_ipv6_mod knob to core code

Ricardo B. Marlière (3):
      net: bonding: Fix nd_tbl NULL dereference when IPv6 is disabled
      bpf: bpf_out_neigh_v4: Fix nd_tbl NULL dereference when IPv6 is disabled
      bpf: bpf_out_neigh_v6: Fix nd_tbl NULL dereference when IPv6 is disabled

 drivers/net/bonding/bond_main.c | 2 +-
 include/linux/ipv6.h            | 7 ++++++-
 net/core/filter.c               | 7 +++++++
 net/ipv4/af_inet.c              | 6 ++++++
 net/ipv6/af_inet6.c             | 8 --------
 5 files changed, 20 insertions(+), 10 deletions(-)
---
base-commit: b824c3e16c1904bf80df489e293d1e3cbf98896d
change-id: 20260228-net-nd_tbl_fixes-ce81ca1e0bf2

Best regards,
-- 
Ricardo B. Marlière <rbm@suse.com>

