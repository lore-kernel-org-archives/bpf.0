Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794374257;
	b=rzxTy+F6hEMkyZ6ZUEkOWmOOomtUgPeVXQU8ea0Z98fzlJCPNMq9Lkg8GIFkMQHFTf1j
	 8NZB1FUT9DmFVEeMqb6D+8uGPHKuLrtSNJiQrs+jeHmey4hRDO17IYgXiq13Fm4O5dzvg
	 uFfzeX8zmAA+VBJ5DLd61e2TIvgWgt9kjLhK5S0QpYpceDzclyrl2tkqTwdlBK+55ccJY
	 KI9K0JDn7mUIQM3MEPNxTLMnDWdv1q6rcyxiuxnU2/nfobRa+brpsvCNo7k7bgiYn/Tnb
	 yeyh4s3dlXvUalBpBKeYBBJmztDsmh9phcxX/Zk7rf1aNsvgym+7IsJDCh3Z7jp6r6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374257;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7gFBZ/Vx/fr0dmA51qEUp5HCxdvTJFezf3qnf4tbl0s=;
	b=hE1yTyCRGvpuwGnuufLJydV7vwCzcb/T53jy81CQvGeEKu0CThVhp4E8TA250CoY6P7R
	 vzb+QjmLDNGmUp9FZFUUgBewcigUXlCGuOwFWorB3nFlRDI2ieQIRWv+6P+Jr29Nt6/Bz
	 S5kZXRhIHEMNvHK1W3JXnR4Hw6Sa5ftGMKvbAhFd0++AXy+E1P5vNxO+hH+DgzEFX0eCi
	 SvtjvIco+Jrb3oIS05rIjfyEHglzeGPg2m8jzprsE549wx3yrga9KCNssN4c8aNO5UKv/
	 p1b7n1VAYPeKxINylJik2RmxdQiX7zEsHqaE/y9i7CdPWoLRgpBkUI77J0raMvRhmEQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lB5giuBX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740C0606A31C;
	Wed, 11 Nov 2026 05:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lB5giuBX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794374257;
	b=x45rgtoUJEOaWdyoPRJsL9LsjaJMViRjFwtzXdyKUc9ur/LqPvkU4+Cn2BB1TDiq3G1/
	 5hxiUODTtc3nqdtIf3YWgAjwWY5jItR+thaXSBKdBF4lXd3vFCPFveW2AnmbFVyPLwp3a
	 uFY5/gA7pIa9fIvX+uxmZNxIbj2Hrky2aaMoebEHbKi4WCMww/r2++ps80/c9nKTj62Sy
	 VHxPrHoFTM0zY0lYxhBfoezfEz2VulZsi2qyhBcl+fhWgSVr7MyO36c5dohEjlnLHL+Ng
	 A4lq5zGWvHfdYlFKzsO0Y2mik4U6BMoKpAc+5HXTJyDPuOKVwfxoSwHxkOIThpRiUEQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794374257;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7gFBZ/Vx/fr0dmA51qEUp5HCxdvTJFezf3qnf4tbl0s=;
	b=DLQYoGR5NeE/psVLTiPrA9HrMyqaKjCZ959xHCGv4SM7vMGRVQyAO6nrp2H1INl3QW73
	 85xkMAUr8GyJjCPL6Lv+XUgPSuTlKQ6dtubncY5u172IGLR0DprIYLzfiOI+kf6MhEtEj
	 bZQ2ID/SO4sJphCCI5qOGlIUHwSwVp/NFYu3ZiCU9XnjctUpLW84ZVuqXkvLwmT0UHXI+
	 XCDNCGbj0DdL+aA5m3rbFo4oH90cJEok45CzMMNr+JtIkt3IRF11/M952DN9PUUgjueCt
	 WWIvt2D4W11HZ/1Cg/Nzj+4Sl7Myrc03D8Bu2lUEuehbzZXo8L8dGotUvtHJ+Q1jBsw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 705E51F0089F;
	Wed, 11 Nov 2026 05:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794374257;
	bh=7gFBZ/Vx/fr0dmA51qEUp5HCxdvTJFezf3qnf4tbl0s=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=lB5giuBXE5gF+OkdQh+v9R0XkaV3Un1Vh0BSpuTGwitsP0ZxMGeuP1zfBikBBoJv1
	 na//7dUAvvGJOOXf5ME2NgYv0QZHhgsUyzXWNfqzHPc1LZbj3HahQwREK5OcqPnir+
	 SRCkFU93VF3lmKg1D3f4H1oa7tRRplNPNdtxju9NSpWuIvf81NIFdZnS2TY/qAujYz
	 VxTR4l0Aag+6rX8WEnoyY/qIgnUbgfLUwIMK4+kV3tB5TM6O3FaY9HXIWiWnyuC5K2
	 f8MhQYszvBIS61FUPNyBVzNfYWQD8N1Ib9MOnuUjRjWUP+2eAymsV8Sr7IpOotsQ3x
	 QdLE5p3Qhd8IA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C336B48D8F;
	Wed, 11 Nov 2026 05:17:35 +0000 (UTC)
From: Jonathan Bastari Thamrin via B4 Relay <devnull+thamrinjonathan.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 12:17:22 +0700
Subject: [PATCH bpf-next] bpftool: Skip cgroups removed during cgroup tree
 walk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-bpftool-cgroup-tree-enoent-v1-1-f3bfcddb4f3d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MwQqDMBAFf0X23IUmtIL9ldKDxqddKJuwSUUQ/
 71L5zaHmYMqTFDp0R1k2KRKVpdw6Si9R13BMrtTvMY+ODyVpeX84bRa/hZuBjA0QxuHPs7T/Za
 GcQD5oBgW2f/zJ3nHir3R6zx/fkAo23YAAAA=
X-Change-ID: 20261111-bpftool-cgroup-tree-enoent-162db54c9a9e
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Jakub Kicinski <kuba@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794374255; l=2201;
 i=thamrinjonathan@gmail.com; s=20261102; h=from:subject:message-id;
 bh=Y/aYjOfjUZxTK7rgxNJ6hCWIgCItIsij9g5tASMpxkM=;
 b=1kWJfLctPEBIdLmqLGPzvNudEJ/L0OIEuQm7UsqIAYo3OVHUE01hYq8YHJYsgr8swa+Ss+oE1
 hyRSYIzcE3LC5YTZZBJOJ5T0u/8lHJc1KhEUgpDTMnxGuTHDkC/c1au
X-Developer-Key: i=thamrinjonathan@gmail.com; a=ed25519;
 pk=mr0q5PZVaUIrv8WvTxIfK7QVcAiRSYI8hOByBQL1ZRo=
X-Endpoint-Received: by B4 Relay for thamrinjonathan@gmail.com/20261102
 with auth_id=1383
X-Original-From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
Reply-To: thamrinjonathan@gmail.com
Content-Transfer-Encoding: 7bit

From: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>

When a cgroup is removed after being found by nftw(), open() or
cgroup_has_attached_progs() in do_show_tree_fn() returns ENOENT.
This is treated as a fatal error so the walk stops and the rest of
the tree isn't listed. This is common on systemd hosts as
transient scopes are created and removed all the time.

With "systemd-run --user --scope true" running in a loop, the walk
fails within a few hundred runs:

  Error: can't query bpf programs attached to /sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/run-p126141-i75408.scope: No such file or directory

Treat ENOENT as the cgroup being gone and continue the walk. With
this patch, 2000 runs in a row complete without error.

Link: https://github.com/libbpf/bpftool/issues/159
Fixes: 2058b38371d0 ("bpftool: introduce cgroup tree command")
Signed-off-by: Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>
---
The ENODEV originally reported in #159 was fixed by 98b303c9bf05
("bpftool: Query only cgroup-related attach types"). This fixes the
ENOENT race that still breaks cgroup tree on bpftool v7.6.0.
---
 tools/bpf/bpftool/cgroup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index fee1a260f6d1..be1c9d5a3bd4 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -463,12 +463,19 @@ static int do_show_tree_fn(const char *fpath, const struct stat *sb,
 
 	cgroup_fd = open(fpath, O_RDONLY);
 	if (cgroup_fd < 0) {
+		/* cgroup may have been removed after nftw() found it */
+		if (errno == ENOENT)
+			return 0;
 		p_err("can't open cgroup %s: %s", fpath, strerror(errno));
 		return SHOW_TREE_FN_ERR;
 	}
 
 	has_attached_progs = cgroup_has_attached_progs(cgroup_fd);
 	if (has_attached_progs < 0) {
+		if (errno == ENOENT) {
+			close(cgroup_fd);
+			return 0;
+		}
 		p_err("can't query bpf programs attached to %s: %s",
 		      fpath, strerror(errno));
 		close(cgroup_fd);

---
base-commit: 0fb18ce8a2e9de830433923cf65838933d615359
change-id: 20261111-bpftool-cgroup-tree-enoent-162db54c9a9e

Best regards,
-- 
Jonathan Bastari Thamrin <thamrinjonathan@gmail.com>


