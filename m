Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D60F406279
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782736382; cv=none; b=SLor37G0XJd1DQsi8FfLJdiJ6+bfWQKNxVBYEToTe/9ko/SlbfauwgsniwY00OxmJg5S+bLTFstrZsofGsxSfqg008WMfubr3wls7P2ry9P6IU+C1V5nuAOznNd4slwlWZ/Yg4l6kxJL/8IdjM8qgjYQB2cCJYR8rSDmRZdYb3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782736382; c=relaxed/simple;
	bh=VYBBozKzX3nXUZNBOwW7N3LxKCX6jGBK4SfsxNXP9Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hx9iZbSoJYG32UCFDhuHaYXkAFCR8phX0eMOlJEzz36vOxQYwxD2xxxi85xFnz8OsCxAfieF2t48SKHczzmLCyXgcuIfYRc0dV1Yces2K1NeeHDOaZHgQlQTFuJNIRRUTVZw2ed8kLsbKsK5bglbPI0V12gvig+4K9Q1wHywAxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Ahiysjm2; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Ahiysjm2"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CE42027072;
	Mon, 29 Jun 2026 14:26:58 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id om40j81T1FFl; Mon, 29 Jun 2026 14:26:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1782736018; bh=VYBBozKzX3nXUZNBOwW7N3LxKCX6jGBK4SfsxNXP9Ww=;
	h=From:To:Cc:Subject:Date;
	b=Ahiysjm2r+4vViLR5sWbK8y0EjdsMFbFFuVbgffEb64jjlIw4eyl2rNiC2WTV7EvA
	 24r7X0eM3cWztcBbO79bKYHQAwHFRR7ZogcZ/2ev4efP7ouVe2HyYumCpw0C1LWv+E
	 WdwrPHNbhxbUclffwcbTC550MZFaSrAs2OYT+FLfHf6Z2JWoQvqaXLE8t1zRU/zViL
	 L993CzFs0ZQv2EhDBZkvMz21fg+oYiAX0M0JFGaXP8aTLNFgzE321zPogpAgQIEkLT
	 aCdL9k1b4PNxGt8ljlLkhuGBS7n2EKmQdZ2x1LRJ9hFweeucon3cPCP4aDUWqh4zhm
	 OBoEMIlrK9BSQ==
From: Masoud Aghasi <maghasi@disroot.org>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	Masoud Aghasi <maghasi@disroot.org>
Subject: [PATCH] libbpf: Add length checks for path parameters before memory allocation
Date: Mon, 29 Jun 2026 13:25:59 +0100
Message-ID: <20260629122559.3828469-1-maghasi@disroot.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several libbpf API functions such as bpf_object__open_file() and
bpf_program__pin() allocate memory based on user-provided paths without
first validating input length.

This can result in out-of-memory errors or different error codes
(ENAMETOOLONG, ENOMEM) being returned.

This patch adds missing path length checks to ensure all affected APIs
return a consistent error code (ENAMETOOLONG) for invalid path lengths,
preventing potential memory allocation failures.

Additionally, adds some missing NULL pointer checks to prevent
potential segmentation faults.

Best regards,

Signed-off-by: Masoud Aghasi <maghasi@disroot.org>
---
 tools/lib/bpf/libbpf.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7162146280a8..bb3f1dd0663e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8536,6 +8536,9 @@ bpf_object__open_file(const char *path, const struct bpf_object_open_opts *opts)
 	if (!path)
 		return libbpf_err_ptr(-EINVAL);
 
+	if (strlen(path) >= PATH_MAX)
+		return libbpf_err_ptr(-ENAMETOOLONG);
+
 	return libbpf_ptr(bpf_object_open(path, NULL, 0, NULL, opts));
 }
 
@@ -9191,11 +9194,17 @@ int bpf_program__pin(struct bpf_program *prog, const char *path)
 {
 	int err;
 
+	if (!prog || !path)
+		return libbpf_err(-EINVAL);
+
 	if (prog->fd < 0) {
 		pr_warn("prog '%s': can't pin program that wasn't loaded\n", prog->name);
 		return libbpf_err(-EINVAL);
 	}
 
+	if (strlen(path) >= PATH_MAX)
+		return libbpf_err(-ENAMETOOLONG);
+
 	err = make_parent_dir(path);
 	if (err)
 		return libbpf_err(err);
@@ -9218,11 +9227,17 @@ int bpf_program__unpin(struct bpf_program *prog, const char *path)
 {
 	int err;
 
+	if (!prog || !path)
+		return libbpf_err(-EINVAL);
+
 	if (prog->fd < 0) {
 		pr_warn("prog '%s': can't unpin program that wasn't loaded\n", prog->name);
 		return libbpf_err(-EINVAL);
 	}
 
+	if (strlen(path) >= PATH_MAX)
+		return libbpf_err(-ENAMETOOLONG);
+
 	err = check_path(path);
 	if (err)
 		return libbpf_err(err);
@@ -9269,6 +9284,9 @@ int bpf_map__pin(struct bpf_map *map, const char *path)
 			return libbpf_err(-EEXIST);
 		}
 
+		if (strlen(path) >= PATH_MAX)
+			return libbpf_err(-ENAMETOOLONG);
+
 		map->pin_path = strdup(path);
 		if (!map->pin_path) {
 			err = -errno;
@@ -9319,6 +9337,8 @@ int bpf_map__unpin(struct bpf_map *map, const char *path)
 		pr_warn("no path to unpin map '%s' from\n",
 			bpf_map__name(map));
 		return libbpf_err(-EINVAL);
+	} else if (strlen(path) >= PATH_MAX) {
+		return libbpf_err(-ENAMETOOLONG);
 	}
 
 	err = check_path(path);
@@ -9339,7 +9359,13 @@ int bpf_map__set_pin_path(struct bpf_map *map, const char *path)
 {
 	char *new = NULL;
 
+	if (!map)
+		return libbpf_err(-EINVAL);
+
 	if (path) {
+		if (strlen(path) >= PATH_MAX)
+			return libbpf_err(-ENAMETOOLONG);
+
 		new = strdup(path);
 		if (!new)
 			return libbpf_err(-errno);
@@ -11432,6 +11458,12 @@ int bpf_link__pin(struct bpf_link *link, const char *path)
 {
 	int err;
 
+	if (!link || !path)
+		return libbpf_err(-EINVAL);
+
+	if (strlen(path) >= PATH_MAX)
+		return libbpf_err(-ENAMETOOLONG);
+
 	if (link->pin_path)
 		return libbpf_err(-EBUSY);
 	err = make_parent_dir(path);
-- 
2.47.3

