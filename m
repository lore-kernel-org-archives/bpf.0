Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6F3521216
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 16:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910112; cv=none; b=gxClr4h8WbdTdMf3rtTT5Q01B1jQbjsfJi/NsmLBaUtOeX+0mq4gf79k7GjzNHsK9yVFlUZVURTuHc4nQEL6XWw/GgEFqaZam6kq5QRIGLE5auyhw7RLup1rWN/AQXVcMuC6mPHZDC83aUzMWXFuSfD2pRIJE0K/rK8tblJlipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910112; c=relaxed/simple;
	bh=K6RB3zG/56k22YI3NmNQcP41aWDJsiJH7Kgzt82dYec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ET8Qhq8dTbLgRLarJcU3AzKsUojSue/eYIDZ1RiddPMPSDQxMqfvd7SaQQYdoVp5WajoMnm/UELL1GgenvMwFBdzTnUTNWe8gUCRsO0cy9sRS9OrDBstfyd1vW6nIkhWpNanlYyBIoUZvBwCO001jvsNKGdpldSJeUZvKviPCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrUaiLvC; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrUaiLvC"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8aca68653e3so493217b3.3
        for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 09:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791910110; x=1792514910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M/dvtBEldp5k/dyI1GCMlCiiP1Mw5D+YND/XHmJTYxQ=;
        b=WrUaiLvCbLZuplWS4/6pNj3dd22buHgUjEBc4nN5pgn/Vdi58E7mIp/7pU4Ul3U8/F
         jprHLi4dYLWvoWLZ8rtHDyaoIdmqGERsyoCx+0RTpw0IBvBbbU7woPXPLzuYedxGEWXu
         VsV5E9QzQzfCQ9bIvKQrYO+CVxVpdw0/cQ41tfOWHPQrP8ht9+hQAWydlknXsWYSZDdt
         BPof+81uKgfEpJZCSYgJXQev+dHQluBr4VLH+FP1DpWjFwEqqic2FSXqQQsfnxeNDJU1
         Qg8AzrObofAeWhYmd75MvZbFej+pejlFLMHgyhkFokUrmjVf6qPUaQMx8HkCn3hs4+VJ
         zz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791910110; x=1792514910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M/dvtBEldp5k/dyI1GCMlCiiP1Mw5D+YND/XHmJTYxQ=;
        b=KKEfhyVg6U7/FoWkZO1a409GcsK8XluQyC9gtiazwG0+euAS7LOd0zPG/v4b3BJlnC
         CkfFBPzLqaIS1ozP/T7frwFawYTUnQB71qD2IOPalKrQr8TBO04Cj/7b6l0Q3bhXiRWM
         KxLBZGi03p8r7QyiZtgkNC+S2g+A76280sXASLaNw4PTpa5jYhtGn9Pnq2vroO3ByKRz
         w5es5RM5Q+pmiTecHh2XlhxCcgjShn2W0rufS7b7OLOSnxZhh1SHGjgbwsnkfifwXcff
         Ro8ZkURxqyaMHBy5wgq9lhKy2jNM3Zmu+P2e+A8stesEG7ANmLKrcIubb7vuguHA+873
         qzzA==
X-Forwarded-Encrypted: i=1; AKwUvBy0Jiw75yImIdSSD7YyCbsbg9gO9n8X+jDPmxd5xmsetEZ+5NDexDDLDFrtgdbK3WnMHUs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJacxEaNxstC3lTNB2jtwRSQa+lZICR72AwjmP8+gxwpKOaGmMf
	WiZyxvhbSbhT4O+pSgPF9eeoVgfGjGg8AiwWMScNJv+ryzD+PqWHev6Y
X-Gm-Gg: AYBFou2kE8mdwSEdLiz1AZi/T3+rx+ylStDeLY04vLV7IOpB4XtRsvSi77ox81UgopH
	C5BkuCU0Qqla4pvjP6NJIVTyzuVqbB2KubV/sT4t5GbwVpCiCdq5hvyt0/knZURaR9r6pG61EG2
	TkEsugrxPIufEwvHMjQs3B+IYr0L3BtxE8BgXq3FWlr9TzUyHNNSDZpB1ihzAi2GBmyVQ8Jdbeh
	ux0om8IdjZa9S3c2FGMmP00DeyhaRPp5oh4wGEu6RzQQuhhoRk8Szl7RKwuJVypqDZXco8ABvvn
	2LNsFz3kOhgwK68pnUh7gcDTJPM8OqQOwuUTP8Y9IF8Xf3KZtl9XxZCqT/Xlz+Y1w8c9wlDvq7t
	Qr0LwAlC9glXZGSp86rTqa1VOkpGL+KDzW1nFUKCQFP7bLay76d9m+TnuFU5OZQx+HaBU/Gzzj0
	gXUICD+0Bbkuy7i79nxj96FJjpg0F//Btcrmu4qsVQkpW7kQu0PMPAdRFYGqg11u17lYzsQx7N
X-Received: by 2002:a05:690e:138d:b0:677:b589:d002 with SMTP id 956f58d0204a3-679362f3616mr5451286d50.78.1791910110471;
        Tue, 13 Oct 2026 09:48:30 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:d326:f863:5ae3:683])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a89294sm81136d50.15.2026.10.13.09.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:48:30 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v1 04/11] namei: expose the stepwise ancestor walk to fs/
Date: Tue, 13 Oct 2026 12:47:53 -0400
Message-ID: <20261013164800.2906577-5-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013164800.2906577-1-utilityemal77@gmail.com>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make vfs_walk_start(), vfs_walk_next() and vfs_walk_end() non-static
and declare them in fs/internal.h next to the walk state, so an
iterating consumer (BPF) can drive the walk with every step and
invariant staying in namei.c.  vfs_walk_ancestors() and its callback
contract are unchanged.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 fs/internal.h | 5 +++++
 fs/namei.c    | 8 ++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index bfe62c9bdfc9..3ce2220ff57f 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -81,6 +81,11 @@ struct vfs_ancestor_walk {
 	unsigned int flags;	/* VFS_WALK_* */
 };
 
+void vfs_walk_start(struct vfs_ancestor_walk *aw, const struct path *path,
+		    unsigned int flags);
+int vfs_walk_next(struct vfs_ancestor_walk *aw);
+void vfs_walk_end(struct vfs_ancestor_walk *aw);
+
 void __init filename_init(void);
 
 /*
diff --git a/fs/namei.c b/fs/namei.c
index 6d5b4b214334..d6151fa27844 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2249,8 +2249,8 @@ static const struct path vfs_walk_no_root;
  * @path: position to walk up from; never modified
  * @flags: %VFS_WALK_* flags; none defined yet, pass 0
  */
-static void vfs_walk_start(struct vfs_ancestor_walk *aw,
-			   const struct path *path, unsigned int flags)
+void vfs_walk_start(struct vfs_ancestor_walk *aw, const struct path *path,
+		    unsigned int flags)
 {
 	if (WARN_ON_ONCE(flags))
 		flags = 0;
@@ -2299,7 +2299,7 @@ static int vfs_walk_step_ref(struct vfs_ancestor_walk *aw)
  * Returns: 0 with @aw->pos valid, 1 once the walk has passed the real
  * root.
  */
-static int vfs_walk_next(struct vfs_ancestor_walk *aw)
+int vfs_walk_next(struct vfs_ancestor_walk *aw)
 {
 	if (aw->flags & VFS_WALK_STARTED) {
 		int err = vfs_walk_step_ref(aw);
@@ -2317,7 +2317,7 @@ static int vfs_walk_next(struct vfs_ancestor_walk *aw)
  * vfs_walk_end - finish a stepwise ancestor walk
  * @aw: the walk; its positions, including @aw->pos, become invalid
  */
-static void vfs_walk_end(struct vfs_ancestor_walk *aw)
+void vfs_walk_end(struct vfs_ancestor_walk *aw)
 {
 	path_put(&aw->pos);
 }
-- 
2.55.0

