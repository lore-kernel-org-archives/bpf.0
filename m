Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D173BE165
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675563; cv=none; b=H3lypAhXLsZJlBq3ImCPpHjeacwyRuWQ0hLLO6Mxtwz2TBMBiSWFxVx/17MZsDNEg0RQiIx5X/7Y4vinmjzSSmlhhHoNWpBnoyMXGMKHpujVYG49FCyQuNd5RkSYQJDKIXE6OQ7hfXHUElbT32LSg5fXwSdcA0iCnMKXzWuwVq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675563; c=relaxed/simple;
	bh=eeBI7yPIkbRxma6M+rsoEvlJu2S4/o6q9xJ3KNzGLxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKDKv2D/4z8s8nuEWGZVs0p97lBmPda8vVbAe5z6/aSTyB3BmV02UWhYINksnkB/UduVSpWknmkyfExDvA5C6Clm/9KddWU8Mya+k+KDnXs9sd/3yxHXiFQYD5KXS06xraEZiCiCDLgnIsSlOOGDE7tb+5+djbAqBs2IgfjeDRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvydO7C7; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvydO7C7"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46accbdfb21so94293fac.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 13:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675558; x=1790280358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uY7UenDuCbnPrSGZzd1x/JKDhtIlnWZbUMTrNeWxAhw=;
        b=GvydO7C76xcCt5C6b8O06lIp4848fB1NE0mo6zxvHeuPkNSTNNB7Nj2FwNsgPqj7tV
         Mit+bbJPysk7XhYLhqxnnDN/dMA3z6HPFZwY0P9AgXNZZURRA7Gke8o5RM/pAWb2a9NY
         fFaeXX6vt0ENUvtGxkNpUJ+EwrfNdAidv7owGs7gtzrgtA3XbB2aDwjrLvDjvKDGz0tc
         QT9Gpge/iHW9knxH3y1+GR7QctT3AzvQOnSn004NLhv/A3Pk6LgTqYzaupUhZI4n9EkL
         EkweNF79QYklmahrpyTczclG6fh8EIkc1oNhn9UF/7fLF/Lc4JBOAgUuuOmBDA2kwWn6
         XkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675558; x=1790280358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uY7UenDuCbnPrSGZzd1x/JKDhtIlnWZbUMTrNeWxAhw=;
        b=O/u9cck0NHlcOkxZIkG9S4gfzH3gmPX6r9SURc4mkEYbLYV1wOWSgT3pAque780c8+
         oAaT+A/zyL/mRivzp2IwK1wvT57XdCA3MAyOWnYgHa0UC4jrb6knYMhoo+TiwtxlJOAw
         QMEuImzf9cfWkW4NvMDPPDSXnI5M2cZdOW39aJoKpbUWEzYWPJXjOf75dLGx9BYdmgyF
         NsYxMnQXB7qc8oAgb1HGBU0jUhUJUd0bnxJ/8S0AcpZdZMqfHKQWAeTmGf+ZuWuj6iVM
         n5cpP3eQUiqER9qW9jnbALNK869B/333wZA+js6cldLs1ESvSFDjxrCGDwm2sSCmFAtf
         IFVA==
X-Gm-Message-State: AFuF++nWJlbhWRBfVYNS+ikCP3cfPFakNc++KCrwfJmhW6cxFfhB3lTU
	Wl37l4OvR9YA2nrFkJbAbCb0fFYcMPUXr9joQv33cgrk4QRELfEErPjwfgW13g==
X-Gm-Gg: AYBFou0Xcsrza3gm0J37Lw2jxrerH1LltIPxwcNt35Rtzjc85McK9BBz58weiRr2GXU
	sD6rSb0GUTJRsuCDVT+YW3mByNcPNV4gow+f60jrzKR67s7DUmoo2j+sffgPIN11fi5LgwtNf7C
	tgxW7jm8Kz9y+V5WC/vw6uyA9O2WxW5d7sSZhfQF325/wuVqETAM5J6GLL22oD7SDuZvB45hQL1
	PVvHaX6nJWCW1BdRH5s3D7DQh2PQEslEvMUfcwYsgSDwPfw/uZXQOUq0uVNfcYIsrdte7UldMRV
	0I9zkWYFyNyPrYf4zntF6PdRvdg1BK+xQlo+nbEykh7NTJcqp9Oj5f+akcj3wHOiZFvZDBE+5Wm
	ABxqm3vEm5kai1aqqK2HaR8BpkA08yv2d7ZO6fMsPzyKFSj28OJtyp6BkmbnGgCO4XRw3g3p+pW
	RhsDhvxaAn0/WnZZblrz+m+o8Xwlc5LtCr5Xjs+gN0xaT+gh3lI/aa5kSq69a0
X-Received: by 2002:a05:6820:2009:b0:6b9:7d9e:5708 with SMTP id 006d021491bc7-6ca9a132f04mr135931eaf.3.1789675558283;
        Thu, 17 Sep 2026 13:05:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c8f070a959sm4262764eaf.0.2026.09.17.13.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:05:57 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 06/15] bpf: Add prog_list_init_item(), prog_list_replace_item(), and prog_list_id()
Date: Thu, 17 Sep 2026 13:05:32 -0700
Message-ID: <20260917200542.3689605-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260917200542.3689605-1-ameryhung@gmail.com>
References: <20260917200542.3689605-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

Add three helpers to abstract operations on a bpf_prog_list entry.

Right now, bpf_prog_array_item is initialized from prog_list_prog(pl),
which returns either pl->prog or pl->link->link.prog. This will not work
when struct_ops is attached to a cgroup because the attachment is backed
by a struct_ops map instead of a BPF prog.

The same applies to __cgroup_bpf_query(). Instead of always copying a
prog id to userspace, struct_ops cgroup attachment will need to copy the
struct_ops map id.

Refactor bpf_prog_array_item initialization into prog_list_init_item()
and prog_list_replace_item(), and refactor id lookup into prog_list_id().
These helpers will be extended to support pl->link->map in a later patch.

This is a no-op change.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 6d865e765d58..bced8e20fa6d 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -399,6 +399,22 @@ static struct bpf_prog *prog_list_prog(struct bpf_prog_list *pl)
 	return NULL;
 }
 
+static void prog_list_init_item(struct bpf_prog_list *pl, struct bpf_prog_array_item *item)
+{
+	item->prog = prog_list_prog(pl);
+	bpf_cgroup_storages_assign(item->cgroup_storage, pl->storage);
+}
+
+static void prog_list_replace_item(struct bpf_prog_list *pl, struct bpf_prog_array_item *item)
+{
+	WRITE_ONCE(item->prog, pl->link->link.prog);
+}
+
+static u32 prog_list_id(struct bpf_prog_list *pl)
+{
+	return prog_list_prog(pl)->aux->id;
+}
+
 /* count number of elements in the list.
  * it's slow but the list cannot be long
  */
@@ -492,9 +508,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
 				item = &progs->items[fstart];
 				fstart++;
 			}
-			item->prog = prog_list_prog(pl);
-			bpf_cgroup_storages_assign(item->cgroup_storage,
-						   pl->storage);
+			prog_list_init_item(pl, item);
 			cnt++;
 		}
 
@@ -1023,7 +1037,7 @@ static void replace_effective_prog(struct cgroup *cgrp,
 				desc->bpf.effective[atype],
 				lockdep_is_held(&cgroup_mutex));
 		item = &progs->items[pos];
-		WRITE_ONCE(item->prog, pl->link->link.prog);
+		prog_list_replace_item(pl, item);
 	}
 }
 
@@ -1343,15 +1357,13 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		} else {
 			struct hlist_head *progs;
 			struct bpf_prog_list *pl;
-			struct bpf_prog *prog;
 			u32 id;
 
 			progs = &cgrp->bpf.progs[atype];
 			cnt = min_t(int, prog_list_length(progs, NULL), total_cnt);
 			i = 0;
 			hlist_for_each_entry(pl, progs, node) {
-				prog = prog_list_prog(pl);
-				id = prog->aux->id;
+				id = prog_list_id(pl);
 				if (copy_to_user(prog_ids + i, &id, sizeof(id)))
 					return -EFAULT;
 				if (++i == cnt)
-- 
2.52.0

