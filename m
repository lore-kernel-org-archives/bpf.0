Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B613959D;
	Mon, 22 Jun 2026 02:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782095656; cv=none; b=PhCzgsxLXwaW+Z3T/A5rYMwcbiBGrtFRPsWByqnGrkAr6YbrT/uobib2uhK2PJap7EpGQfht3UG+1/x3KT4yL6vEuahW/q9AJw2HDVCeAnURH7wa+IUqCaPALGHIiVnetFwcTWS+F58/2psIyZnVKrZtEPXxt6MGmjZ8PASjmpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782095656; c=relaxed/simple;
	bh=5pLaXpi9ta0wJh8y99pP4SfNdJSepAWpdPLfg40Ic4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPpqYDCenXR5QZnJ5oIlpHVDF0Mq0e1LinT1G948nbkUCRVKC+pBu8xNSbRafByJrQjZJsclqIuW2hNwBkhFxPa5vnmbR/GD0HaCePLPAmQLSowqVs3IVlQ0YF7gydzAj7PGEJc6YCXvHFCBfLJAHsdvrXK/5MA+1rcAg1Vg/Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=etpqybiF; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="etpqybiF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782095646;
	bh=1sRKdeOKdBSdB4sudZ16ZGQ9XfNvCZgI9lgpnqbMA3U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=etpqybiF577QVaAtyB6GCb+HCFHjhc7Jckc+rIXdMAQI059p53FdXbM4M/YInPu3X
	 pVqbopidbd3I5vZadtnwHqUsPUZcVfW+KQmi1L41GQXBpOZP9Ck1UVIfpg7K9rFx+K
	 DpTdW6koWgA4DKSa/t1KRr7SiDGMiWD6YnGYBFsw=
X-QQ-mid: zesmtpgz6t1782095642t7fde8a4d
X-QQ-Originating-IP: ByrAPzw7depav/XIWkWc4fah7cXVhtpMfXbK+3ltQ0w=
Received: from Shurima ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Jun 2026 10:33:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 946799312610904517
EX-QQ-RecipientCnt: 13
From: Yichong Chen <chenyichong@uniontech.com>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyichong@uniontech.com
Subject: [PATCH 1/2] tools/bpf/bpftool: Reset vmlinux BTF after map dump
Date: Mon, 22 Jun 2026 10:33:44 +0800
Message-ID: <E369B37D2D3B6B9D+20260622023345.1135373-2-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260622023345.1135373-1-chenyichong@uniontech.com>
References: <20260622023345.1135373-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: McoPngcDBvM5NHG7zpQxGq/CgoKCnSV2XhsqAcIVW93ckwuAcdHoCv/v
	tjWvlCeoBnWrbNhKtbk0E4f36zGDhc0z96MU5dpO9Vf9TsePd49TH3xkwAnkMsp4Ha+qucF
	0HrJp/npsV7LYDq48lJ2fAjp+HQHEupDhwV6h+lDLlDmoLuZys8tE0BkMrwR4nOanYzmvD6
	NZpM1TRE86Nqt4kgAM3cnWbYacZfREpWnYkcqaYVfVqctoTfLiqBCHYeWnOcejk7hFfBayG
	PdCeAfjqPcM0OVufGfP+wBVGGKVKP9yLYAViLODjH8ZtKj4Nhv6PNOC2O5APfddlRTXOaoh
	dJG+D8W/7gR5Gmf+0t4Xt3WjGDE2sIZ2ToA9r0T+QXC7Yw2GKoYTlKUczIiCCdyK6UQ0w9y
	ztlufV9GJNSV27SOP8UsjupGi6IJFBNy9nHIWlxSGFzatBzbaI4KEX+IV6i83v5xc6vH5WR
	5AiUWgcpASjCQm0iSyYFkT8cl3phT5dVv/7Sy4OrvsjQgdF2GNGKnRoz6i52YYgsLviONID
	L1b3p5eH4ZICPHrjPz4YLLl5FpoQfwzn5KBrfV3IsP/YJsBjWclTRn4FB+8fukVQ9TocJ2o
	6I6mI/SRMyHu1xIxomKXo2oiFE/nbo9wzfCBryIhsvzMvsrKEQrRjn+m0qhCB33v6a5X1TA
	em4e2LvpCr5J+gBy2ZtTH8khTZCFlYJyxRFXwUBWZvtmAuEDWJmDcUgfPPeOrGA0Aa9jKv1
	NhdhDNhXcdxVKESqgCktfg3FZ85LymNGzXwPIAwp/5ZExQUWLsP3emzi/bcEgOG3H7GLG/j
	OEfAbOo/Ew4DsVoQc+iSY218lWYNVm92FxbZCxdKO3YyYzHO0f6QbaJSpcrvh/NThv0BLG9
	dCPdhqBv08Prn4kDw0uTXfHQIujLRdmg0A21E7KxqMahNriJRDmPrBlhPSJ+r+taBYeV0t/
	393ZiMnPknIugMNj9y2WypjM75pJ4q4T++l2f2fespLmobwjNXXy3VHhiNrHuTRvpB4kCJd
	FeClD0QMg7Cy3YG7Hl4qdnCc+D7kQMONtcduFSY4o/9D7T9dIc
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

map dump frees the global btf_vmlinux object.

In batch mode, a later map dump can reuse the stale pointer.

Reset the global pointer after freeing it.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 tools/bpf/bpftool/map.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 7ebf7dbcfba4..8aab9ce743cb 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -790,6 +790,12 @@ static int maps_have_btf(int *fds, int nb_fds)
 
 static struct btf *btf_vmlinux;
 
+static void free_btf_vmlinux(void)
+{
+	btf__free(btf_vmlinux);
+	btf_vmlinux = NULL;
+}
+
 static int get_map_kv_btf(const struct bpf_map_info *info, struct btf **btf)
 {
 	int err = 0;
@@ -958,7 +964,7 @@ static int do_dump(int argc, char **argv)
 		close(fds[i]);
 exit_free:
 	free(fds);
-	btf__free(btf_vmlinux);
+	free_btf_vmlinux();
 	return err;
 }
 
-- 
2.51.0

