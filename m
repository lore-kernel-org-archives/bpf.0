Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775F3C9EED
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225906; cv=none; b=m9eYhYIbE448jjoj29j8XY7Cb7M8Rho1ZQ1ATkBmzuZXTdgmRCyFUlNNX2tJRgUMgkwUFZaWqpTxIw95ZytKD4WipJ+HG2QLvlWJBOmR5pbDAJAcgrtkLuvpdfm3r8ZR2sk2O4lAmEgeGCtCheT+G/tkr/GHr0pjSPgL1+od6gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225906; c=relaxed/simple;
	bh=sZNi6xg9sflBEGhOc7EN8IGrWBPWKS1LHIHSe3Ram6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhVvVSfwz5itWmMUkBay/3hH7rN4c7HqiNpS9b0AIzb3BNGnFMifSU2DF9QSU23/AQQ67q7grWrFgW9ICKIL8P5KIlhj3xMT6c4zpxx4NTq/mUHWVqKQjNQL2OvUUgAgOpewfB71rSrNHGAWow7Jj3vAmmsoO7QrJUfeWouDx20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCW8H1+H; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCW8H1+H"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c858014845aso620808a12.1
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 07:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782225904; x=1782830704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2cAvGjsb7kwxKnrggDL0ESG1XH4uHWWvpVFC+MpwI9o=;
        b=LCW8H1+HnWXkd8L8LdOLweY1uEVX+0ymxJJ8yQnr94l0NhEKz86L5K/d9L3+VzjY9L
         t/Ayf9cUwfboJXLY+y/Ez6wmoEoR3ty3JXMYK1EW4R1F/ZsLyT/3PnXcm5DA37Mt6kmn
         Wx1C1mwnMwd9N8WlqWckjABIFHy7+rURt8vKWQF2XvKU+5Pd1ZfhDf1W+281gLncamdg
         dezVz32wbvHxCwA2qtluzKXvYVHSRxIPWCRFstM0n3DQCSt4NKCmvB3Y6rYWGxJv9kDf
         qYWKwfNeE2LQbdz0b0JMKgJdiS0kKI6E+vctTxQT5MFCEuYMat633DXM6FBdURwradB6
         S34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782225904; x=1782830704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cAvGjsb7kwxKnrggDL0ESG1XH4uHWWvpVFC+MpwI9o=;
        b=h6lptorPORXcj948yQ5GA8IhqAJCsqmGY5ZO6njr8mdy1E4gWfoYEZ3W8ew9XQ+VkP
         P3DfsUBdbdU7SlxxuUzIKRgwV5uc+2k6jy+ZSPRLcnSUcznMW9wWHSnN8z1xDvez8C6I
         jgZV3RhErnbhtjh1FbinYz491uZ/Rhygy8ZIG5eoCVf78MdcC402LMmSlreFAeaLbk7Y
         7hh7q33+sm/kHPs2Xm3mvCVnrOVXePHGQG5sNcyy4OFoa0hVnemZxHjWpV2v5WgLEScN
         wH/pWk2gf8IAyDh3u9QXdvVDCsUvDM1Zk3cwoe3M4F2bcQZ6T4dDgR9DMq0dMnrP/OAU
         5JiA==
X-Forwarded-Encrypted: i=1; AFNElJ9iWK/wPa6W4ke/ziN9q6Rs2rY2wf3GPyo9w4NeLDeQwqL1rhusRYDLLtLOHMgFI8WCpaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh6TCiouL9GHm/d6DNFLzIANWWvN8/jl8PxjtDrhwgW+RqYf69
	nUx6VSXiz+52B0S986GzzbdeIHmnaG5N9AdF559UAiMCjk9EdoJOnIqq
X-Gm-Gg: AfdE7ckkzv9Sylgbw/jrQgaml6p9SZxuUcaYRVF5Kg+NE0JxTVI1orrvlkESn1RS0VX
	pU2oS6fxXkwddcO81lp81iEDSHzBi1YDcruUmCyQfbxHEjUOWVP9fg6XsXXlknqyxoQsScbj+WG
	A0yZ6EBtygoz0IPVhnXVqWm/b1UBJWto74jc+4DQt1tMbpnfFabmx9Fl0ZBP0pjQU5c6PK6MM2P
	GMvHB7HUH8xjATYm+EMsbxzbPl8f1WeoVW7QuQ38gB0alFmVl28P+nLxru4FI1V2uJ2AtssOGVn
	uC3nWH77u/jVlph7h913nAb/lzH4S1Ia6GIvfpkOuxDECwMBggZIb2dIDziT/JIkez+9TQ2Jm9W
	PgmwpsP1Z2z4qTBHdZxIDHX1nJRtbYIb4atSXVkVRIOOKZzwgT1AQIzYxTkjr9pUY/6ObRrMFGG
	YpDJ0aCMb7AEZRw09HHcl+
X-Received: by 2002:a05:6300:8811:b0:3a0:c246:bb98 with SMTP id adf61e73a8af0-3bd10b3de08mr4191736637.29.1782225904306;
        Tue, 23 Jun 2026 07:45:04 -0700 (PDT)
Received: from i386.168.1.127 ([150.107.232.166])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc5a1dc13sm10229638a12.26.2026.06.23.07.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:45:03 -0700 (PDT)
From: Hrushiraj Gandhi <hrushirajg23@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com,
	Hrushiraj Gandhi <hrushirajg23@gmail.com>
Subject: [PATCH v2] netdevsim: fix use-after-free in nsim_create and __nsim_dev_port_del
Date: Tue, 23 Jun 2026 20:14:47 +0530
Message-ID: <20260623144447.255326-1-hrushirajg23@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

debugfs files created under a port's ddir (ethtool/get_err,
ethtool/set_err, ring params, bpf_offloaded_id, udp_ports/inject_error,
etc.) store raw pointers directly into the netdevsim struct, which lives
in the net_device private data kmalloc slab.

If these files outlive the netdevsim struct, a concurrent reader can
trigger a slab-use-after-free by passing debugfs_file_get() (which only
checks dentry lifetime) and then dereferencing the freed data pointer
in debugfs_u32_get().

In __nsim_dev_port_del(), nsim_destroy() is called before
nsim_dev_port_debugfs_exit(). However, nsim_destroy() calls free_netdev()
at its end, while nsim_dev_port_debugfs_exit() removes the port's
debugfs directory. This means the slab is freed before the debugfs
files are removed.

The same window exists on nsim_create()'s error path:
nsim_ethtool_init() creates debugfs files under ddir with pointers into
ns before nsim_init_netdevsim()/nsim_init_netdevsim_vf() which can fail,
and the err_free_netdev label calls free_netdev() while those debugfs
entries are still live.

Fix both paths by calling debugfs_remove_recursive() on the port's
ddir before every free_netdev() call. The subsequent
nsim_dev_port_debugfs_exit() calls become harmless no-ops since ddir is
set to NULL.

Reported-by: syzbot+6c25f4750230faf70be9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6c25f4750230faf70be9
Fixes: e05b2d141fef ("netdevsim: move netdev creation/destruction to dev probe")
Signed-off-by: Hrushiraj Gandhi <hrushirajg23@gmail.com>
---
v2:
- Also fix the same use-after-free window on the error path of nsim_create() as suggested by Simon Horman.
- Shorten the code comment in nsim_destroy() to be more concise.

 drivers/net/netdevsim/netdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 27e5f109f933..f2824e75cddd 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -1165,6 +1165,8 @@ struct netdevsim *nsim_create(struct nsim_dev *nsim_dev,
 	return ns;
 
 err_free_netdev:
+	debugfs_remove_recursive(nsim_dev_port->ddir);
+	nsim_dev_port->ddir = NULL;
 	free_netdev(dev);
 	return ERR_PTR(err);
 }
@@ -1214,6 +1216,13 @@ void nsim_destroy(struct netdevsim *ns)
 		ns->page = NULL;
 	}
 
+	/*
+	 * Remove per-port debugfs files before free_netdev() releases the
+	 * netdevsim struct to prevent use-after-free in concurrent readers.
+	 */
+	debugfs_remove_recursive(ns->nsim_dev_port->ddir);
+	ns->nsim_dev_port->ddir = NULL;
+
 	free_netdev(dev);
 }
 
-- 
2.47.3

