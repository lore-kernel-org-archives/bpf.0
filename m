Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CF930FC1D
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 02:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481909; cv=none; b=ik7nlFUHJVZm1cwkxRg3/ecbVm9Y56SahxxItpopMuVpD2Sw3sDX4mTN8e/voVJKHEsxQ/Gz8UNNgXzO2ll/VqDhL7wqeXdjzrb2I9TI9EHHo3B0Yn9iqslcLO5HdP9WON1VxPiIq+GntMZTjyH4k4yHJsAk7Q+DQujiSyjMhSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481909; c=relaxed/simple;
	bh=yo2AA63J/CrZd0KKpYjpWSjREQRN37J8XoT/k5k6NEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9zHB8Lb15x+HlKhZJxUNfuzFf95tKWpz4u1f2CKQgMlx0XxoBPpw4v+nf3un+fv0xxVz6wMCAsXXdlbola89CljuOxkhBYUreS7VOIAtEcJOJhiFv5ZE1wtciCinHtosCCRcGb99Eb6VE8AmQ8W+IkqwD2xfvs7k4jHvkGBpmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MVYbxj8b; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MVYbxj8b"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769481906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5kycmWS+Mn50NTNG9vDPdXnOmThXS8tkuWasjOZWHyE=;
	b=MVYbxj8bguPU/jWUxphCtMV2M4pyasjfYogGFJ2vNcT1KF2goib3pEeYc8kLCil+Me1cqA
	A+YE5JjAKsshrTPbuVZ0E9j1WggR0qhRanDpJE3AsiU2VhodIOexFViw0YdvUqPvkcyoBD
	IpQB4/liQnnBeuM18rgJmTEtSMseg/k=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: bpf@vger.kernel.org
Cc: Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH bpf-next v3 11/17] bpf: selftests: introduce read_cgroup_file() helper
Date: Mon, 26 Jan 2026 18:44:14 -0800
Message-ID: <20260127024421.494929-12-roman.gushchin@linux.dev>
In-Reply-To: <20260127024421.494929-1-roman.gushchin@linux.dev>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement read_cgroup_file() helper to read from cgroup control files,
e.g. statistics.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 tools/testing/selftests/bpf/cgroup_helpers.c | 45 ++++++++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h |  3 ++
 2 files changed, 48 insertions(+)

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 20cede4db3ce..fc5f22409ce5 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -126,6 +126,51 @@ int enable_controllers(const char *relative_path, const char *controllers)
 	return __enable_controllers(cgroup_path, controllers);
 }
 
+static ssize_t __read_cgroup_file(const char *cgroup_path, const char *file,
+				 char *buf, size_t size)
+{
+	char file_path[PATH_MAX + 1];
+	ssize_t ret;
+	int fd;
+
+	snprintf(file_path, sizeof(file_path), "%s/%s", cgroup_path, file);
+	fd = open(file_path, O_RDONLY);
+	if (fd < 0) {
+		log_err("Opening %s", file_path);
+		return -1;
+	}
+
+	ret = read(fd, buf, size);
+	if (ret < 0) {
+		close(fd);
+		log_err("Reading %s", file_path);
+		return -1;
+	}
+
+	close(fd);
+	return ret;
+}
+
+/**
+ * read_cgroup_file() - Read from a cgroup file
+ * @relative_path: The cgroup path, relative to the workdir
+ * @file: The name of the file in cgroupfs to read from
+ * @buf: Buffer to read from the file
+ * @size: Size of the buffer
+ *
+ * Read from a file in the given cgroup's directory.
+ *
+ * If successful, the number of read bytes is returned.
+ */
+ssize_t read_cgroup_file(const char *relative_path, const char *file,
+			 char *buf, size_t size)
+{
+	char cgroup_path[PATH_MAX - 24];
+
+	format_cgroup_path(cgroup_path, relative_path);
+	return __read_cgroup_file(cgroup_path, file, buf, size);
+}
+
 static int __write_cgroup_file(const char *cgroup_path, const char *file,
 			       const char *buf)
 {
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index 3857304be874..66a08b64838b 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -4,6 +4,7 @@
 
 #include <errno.h>
 #include <string.h>
+#include <sys/types.h>
 
 #define clean_errno() (errno == 0 ? "None" : strerror(errno))
 #define log_err(MSG, ...) fprintf(stderr, "(%s:%d: errno: %s) " MSG "\n", \
@@ -11,6 +12,8 @@
 
 /* cgroupv2 related */
 int enable_controllers(const char *relative_path, const char *controllers);
+ssize_t read_cgroup_file(const char *relative_path, const char *file,
+			char *buf, size_t size);
 int write_cgroup_file(const char *relative_path, const char *file,
 		      const char *buf);
 int write_cgroup_file_parent(const char *relative_path, const char *file,
-- 
2.52.0

