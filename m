Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D59D3F410E
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787651420; cv=none; b=X0JxAuSRoZDNtTa8iAaTj4fdzH9IN4/5yQZGUvCmyu280AiYy1+6sYS68pv5klig10+L9YrPMOrG83Sok9k97WKwtBXNrzwN18GbFe2jiD/rcZ/bnPbsWX18ywBNiFL29F43rRFxYZy5h/uarXhn7soy51ACtBETF2wxaRiVzhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787651420; c=relaxed/simple;
	bh=/yvTesosUitvxpBGbkVrq+T3ZwnrBfxMu1Tk0/tPvCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubhjyk0FEOZ6UxLGd16yuzJLgT3kV/cvIb7BnfTCUT4b9vxeuFXzyxL3rzH8Kbr3e5X27IIlt10cy8cpbdjSURYjII3gZZdM2DdZFkczpaMn46LubY3u0KTbsO361td4cYX+Q/86+i/q38/e92O/s/AcBHfwZC8WbnUiyQS4r98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CngOv4bz; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CngOv4bz"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c999f162c9aso3261457a12.3
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787651417; x=1788256217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0rBrebsEU++q5oyTmtoojXSPfykwosiXDRrVD5SURpU=;
        b=CngOv4bzYh+25ozMucU3E6MIUefWURDeHhjBbjDsIW4AimcgCwmuboDqdUbU9p3M3k
         7/Boc0MPIbzZwAAyo/j7VAeGsGncu5xwleC6zY9zCVdSoSgFVNi3RrWr7O6IdbVgkmC/
         xhKI67Yb4vI6K0eiBFqo0YkmQTkCA/8ulIpLpMKLb2Iet4InUKfyzNfNMRJvbhCcxLvX
         qQJV/Q0NqlvxDQy5cPlTAAZ4G4F7aYlaNlIxeeawtpEMUjanvr97QsvLEryK4r93cMkh
         b/RyC4VSERs9xfk64vPm5QZPwHKickM1q3ArX+AG/gIOdZgsRLFZ+tDg3/JxX9cATL7i
         bi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787651417; x=1788256217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0rBrebsEU++q5oyTmtoojXSPfykwosiXDRrVD5SURpU=;
        b=mW879hwY5g/3/HhOyNuq5GqiFk1RqLqxy8xSZpNZIoGTPYwi8FgA4OYm3egP0eLg/Y
         QgLmbNu1z/R1Fy/VgKcyWG+T4KC8qAnEJg2ehR5LN1tukb6KF5j6aPbxC6v21cGWmt2g
         o9Vk3kkkdU9ChegEAVzJrXpMo6eFIfVUlJEjyw3ByI7bOLFceMl/Enzk4MwnQ2/arido
         CfUFX9W0W3PRdn0m+F5GPx5ezEIE661Ky44oKQMvze6+rNxHgKBQ3zt+lHg930KHedK8
         YcmZIJk2otrBzBHkFRJX5s5OMEzDwix0mHtND1d/P8JPyRzoyT6d+/Qlj2svg/cjFbkB
         UQhQ==
X-Gm-Message-State: AFuF++kdck6sI5MycGGZSwaGIgwFtznoNSvbkGVJUrqXvs0A8mkZCHgl
	Wl71oUr52RVPMoR+pVrSyYTOKBVIvRxVTVLDH60g5Ul7wL1wqnScgqjagCHBXtfD3wE=
X-Gm-Gg: AR+sD11eDUmOR900n6HKNqBUQJMHVzesW8B1DMWtY0P+rbiCHiQim3OF1n0jzKCAVee
	b4BD/yUuMcUF68NIThDbfrqF/WXNB/9qYlBLfBHt+c2p/6Rb57dmYjoDdAvq0kreMWs8JHUogKg
	P7lnii85x3QBXk7vdz18AvffVnUmnGx4KRvSlhwAAUnRhWoSaH0tbEcUW6W+YF0EwvqsbT+qt/+
	Ako1McXakRuuQbtStgNWqri3k75KLdX8iyMo6gww57FAXjD6Iqp+gM9bOfAJ1F2e2AAI/8xtY8g
	E1JrrfFuiQvQNJcEe1w1fwwxOq1nIXM/Rl3tXvIZZuN/1mXio6PSfVhGilnS6hKtQMP/AClv4ZY
	P5MBXCHBQskCSbF3cdD2ts7imKBiJulBTiKDxWD6vapoj5MKQSzs/MIN/Igx4q1J9Y7iD4fFbD2
	vSpz0Es28bpBeYDodM2DXQJKa0Cj6m/IfwOmugqGvXNuTSaz2A0RB5oLxnghiBT7n3jA6UCTDpg
	sg6ojLt1gmx+sDEsPQN2WkH
X-Received: by 2002:a05:6a21:138f:b0:3c1:fbf:1e2e with SMTP id adf61e73a8af0-3cd3008bf4bmr56836649637.10.1787651416876;
        Tue, 25 Aug 2026 02:50:16 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32827662702sm5923062eec.10.2026.08.25.02.50.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 02:50:16 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	jiayuan.chen@linux.dev,
	emil@etsalapatis.com,
	ahemadkhawar123@gmail.com
Subject: [PATCH bpf-next v6 3/4] selftests/bpf: Add read_cgroup_file() to cgroup_helpers
Date: Tue, 25 Aug 2026 15:19:54 +0530
Message-ID: <20260825094955.83240-4-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825094955.83240-1-ahemadkhawar123@gmail.com>
References: <20260825094955.83240-1-ahemadkhawar123@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@linux.dev>

cgroup_helpers has write_cgroup_file()/write_cgroup_file_parent() but no
read counterpart. Add read_cgroup_file() and read_cgroup_file_parent() so
a forked child can read a cgroup file (e.g. memory.current) from the work
dir owned by the parent that set the environment up, without hand-building
the /mnt/... path.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 67 ++++++++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h |  4 ++
 2 files changed, 71 insertions(+)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 45cd0b479f..4183ff6150 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -188,6 +188,73 @@ int write_cgroup_file_parent(const char *relative_path, const char *file,
 	return __write_cgroup_file(cgroup_path, file, buf);
 }
 
+static int __read_cgroup_file(const char *cgroup_path, const char *file,
+			      char *buf, size_t len)
+{
+	char file_path[PATH_MAX + 1];
+	ssize_t got;
+	int fd;
+
+	snprintf(file_path, sizeof(file_path), "%s/%s", cgroup_path, file);
+	fd = open(file_path, O_RDONLY);
+	if (fd < 0) {
+		log_err("Opening %s", file_path);
+		return 1;
+	}
+
+	got = read(fd, buf, len - 1);
+	if (got < 0) {
+		log_err("Reading %s", file_path);
+		close(fd);
+		return 1;
+	}
+	buf[got] = '\0';
+	close(fd);
+	return 0;
+}
+
+/**
+ * read_cgroup_file() - Read from a cgroup file
+ * @relative_path: The cgroup path, relative to the workdir
+ * @file: The name of the file in cgroupfs to read from
+ * @buf: Buffer to read into, NUL-terminated on success
+ * @len: Size of @buf
+ *
+ * Read from a file in the given cgroup's directory.
+ *
+ * If successful, 0 is returned.
+ */
+int read_cgroup_file(const char *relative_path, const char *file,
+		     char *buf, size_t len)
+{
+	char cgroup_path[PATH_MAX - 24];
+
+	format_cgroup_path(cgroup_path, relative_path);
+	return __read_cgroup_file(cgroup_path, file, buf, len);
+}
+
+/**
+ * read_cgroup_file_parent() - Read from a cgroup file in the parent process
+ *                             workdir
+ * @relative_path: The cgroup path, relative to the parent process workdir
+ * @file: The name of the file in cgroupfs to read from
+ * @buf: Buffer to read into, NUL-terminated on success
+ * @len: Size of @buf
+ *
+ * Read from a file in the given cgroup's directory under the parent process
+ * workdir.
+ *
+ * If successful, 0 is returned.
+ */
+int read_cgroup_file_parent(const char *relative_path, const char *file,
+			    char *buf, size_t len)
+{
+	char cgroup_path[PATH_MAX - 24];
+
+	format_parent_cgroup_path(cgroup_path, relative_path);
+	return __read_cgroup_file(cgroup_path, file, buf, len);
+}
+
 /**
  * setup_cgroup_environment() - Setup the cgroup environment
  *
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index 3857304be8..d42d2e1304 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -15,6 +15,10 @@ int write_cgroup_file(const char *relative_path, const char *file,
 		      const char *buf);
 int write_cgroup_file_parent(const char *relative_path, const char *file,
 			     const char *buf);
+int read_cgroup_file(const char *relative_path, const char *file,
+		     char *buf, size_t len);
+int read_cgroup_file_parent(const char *relative_path, const char *file,
+			    char *buf, size_t len);
 int cgroup_setup_and_join(const char *relative_path);
 int get_root_cgroup(void);
 int create_and_get_cgroup(const char *relative_path);
-- 
2.54.0 (Apple Git-157)

