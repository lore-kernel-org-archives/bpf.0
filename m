Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D418B3D9DB1
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 09:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649429; cv=none; b=a9GByg/eviddqWU31tkAZ5S1vZRzSiCi4YQ1nXQW7t2WQWkOWIMg3RGHrlNkaVqw7P8+WlFAAVfn+f3RzxCIzKiLYkYOEvkFGhhoUYq2CEXyimIfKtesCkKlTmvmegXsjhSAIq6hOepKcTT8ZXqcnkMa5q+P81hZE/00igCT6tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649429; c=relaxed/simple;
	bh=6Z6Q5pPOjFxZCt8cI3vyHstO1u6wtP4+biQ04XHKri8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pa/eSdZBQ1/d5oB0t5uRxOOFN4g2eNrU1LjAHFyPd3v7LVqEY7dv4aS0PFqIfraQ1Z9zJJ16U8030c3tV1jqy/X6LsxBmWkqibHRT7iltCeQ9hp6s0FTpR8M5XbjYE3ijdcK8VpBv+l/Fe1ejf7/r9OBiXmAzGuziao/suJEv4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4XifViY; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4XifViY"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1a4c62804so1676242a12.3
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 02:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787649427; x=1788254227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l6cOQXsmgqLviVD25X5rJGEEdQ3Qp9SiwjwLR9fqyds=;
        b=r4XifViYSBAFRrpivNFWKZwelwO0otOgqGxn06YSeysNa1uTPXk5OGBD2lmqzyctXr
         QrF0uyjdHOIDn92crpeHMTYbCXpbBIWdPZiMYffMOYewQnyIetmVYUhhQVvjTCTmIcb3
         RcvIE4KkuHRd5Ctlh8rErgz+w+lAwGlgUc/fU2Zb/DIVGbhCuFfiHYrIkZUQjlmpwxQ6
         H7KBzlw6yMoxspMmuEMcuzJvb8QLsCjBbZgWuET/GjX2ZIPTX32AIp1kWWKiQf+6h+iX
         p6QSVf5mEB4FrbjoAB0wjI/9uvlfbM7VNtzicaIrw3OU3hv5sP3GUX7oAzgLLE/1kJBT
         EtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649427; x=1788254227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l6cOQXsmgqLviVD25X5rJGEEdQ3Qp9SiwjwLR9fqyds=;
        b=f/yVtIgarZjb7DoRo3vRyhBWdZjayLTRFEWGpeiwl1aP1H320AK31agpETF5fxUzPb
         tNE4AhvFtJqNcLzvK2AoILB1cO1t45Ue95y+0GboCOedpsZrckAiKyRwmFUF6oqmzTx7
         NLkAEVy99mx87EHraoxoL999iSKLgQ80M5GXOEg8Tg8AsSIOfTbQvwkyw3IG+W209UuL
         6JkfljZm76NCGOQWcHN7gQu/bAv9FxJmWvrodpdXZCpEnltPhfQzQl+4WcKnMDwBUNFM
         NCRSfsn7Z1D5R+KhqR6avcqZkTsJvEvt+nd7sfc5oAmn3+2Qa0Ksy4816szkTd1AdmxB
         JkOQ==
X-Gm-Message-State: AFuF++n5fvJ1lNPJFGTUpKtgZOoMkO3ddCyOfmOXWD+6aSrPunXjri78
	7qqL4mFbYyKriHyfLFIOqop8KsIXfo4ecmZSVSCiILYnucUaCqnlRqCGP+8h0sH5nWw=
X-Gm-Gg: AR+sD12p30QU1ebTXmTKMoUv89fZ8GcSzH0U9/kDtqT9lvSpWt6VEb815hNPW1Z7Pma
	fF+9hVXHRvqB+1yJZ8BiirL3UAy1LAultLV2FOkaOsGHhApQ/m5sxEMm5IcIEvBPjFKnwNGywgO
	fwbPXezhY4CdGcX1O3uHZ39vjmz2JD8SjqtmJTOJgtx3Yh9xP3lOZhOlTMHayEY0vhs6TJC7Awy
	2vvje3TfEzy/9FetGo5CLPGdNfAIJWf+cvRiSYvUMSGGJsIj2rU7LvgFnQQ+Vb2B52rOKH/xcCo
	vt7eqDuTTIDiOd6sb7Tk24CVnsLxXRIBcwoNdaPjibOH17MTFheGMNnKovFP2ae+P7eOg27X6Xz
	vyWdSL5K4CLQmyCDLeb20B5EZ+/EnHronjDNQMpiIUa2H0HqEHc13ymUe82gJchiEcS/b2T7jxO
	zsx1m+3d+BLk4hkO0biTUftqnUAd74o4znyI6DaCrvl7RQVzccSLsaAnMP/D4di6yfUVprMl+n7
	7FSr2vai/egHXjxxf+Dc4F2LnPePQ==
X-Received: by 2002:a05:6a21:9214:b0:3cc:f280:ebc6 with SMTP id adf61e73a8af0-3cd4ba4839amr55998320637.5.1787649426894;
        Tue, 25 Aug 2026 02:17:06 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860fe08csm52122658c88.8.2026.08.25.02.17.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 02:17:06 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	jiayuan.chen@linux.dev,
	emil@etsalapatis.com
Subject: [PATCH v6 3/4] selftests/bpf: Add read_cgroup_file() to cgroup_helpers
Date: Tue, 25 Aug 2026 14:46:46 +0530
Message-ID: <20260825091647.81632-4-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825091647.81632-1-ahemadkhawar123@gmail.com>
References: <20260825091647.81632-1-ahemadkhawar123@gmail.com>
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

