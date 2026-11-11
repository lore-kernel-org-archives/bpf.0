Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398392;
	b=b2vm7oQ/1RqN5DrCT/4TeQRyYCHnpAnxlDzTh7CJ73F0ZABDdxj2PlI74bvpIfL5kKmK
	 x6GNYgEKK/3rpm616aVKd4ChuYuSj5Rj5lOLO5sE9l4xubR2MjvCynpsV3V3ci4PlBTtK
	 htkpXBTnkNzJHiGh4IoUiP5Y0FHChBOjyoOa2unkMZdXJUw85jF/JlRsQzeM4dIG5Xb73
	 Si1YooZ6nD4K3ujVCpP0385GsNzM7jlBjJAZEM9rsVxmMOIYO/kyL75jP9/Q7JjkDlO2Y
	 NOTC3WCitP6bbbTHjXqZSOEzrFhoPoNJ0IAKOGJ6rwS7yJYaEUpf+EPRuOY1YDPv83Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398392;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F42lcRumFDtpy3odmo1wxO6UuJDNkbkiUxHz5CuV8Vk=;
	b=uhb+oim+6BoDjf3HVl9fYsA+KPnjBVej2QCjfx5FSyEynMCQoFa2n/mgadqYZudkPRVs
	 I0z4u4O3BzvQg3gJdDXkr/pVTjgjbNicsjaPHdKKYF8oysVHo1SmGHtr7HgJ6WKPN+tW/
	 nHn4hoU8b0YLARPz++6cLa2jIJ+cMwVSY8VxjPni4U/GzrQ1/tI4zZ4zoCLlJnqnWTu07
	 SAu7T4ZKaFa+mF4LeTa9KQ+mm/y1Mm4jAZG2h8tD5KlTqSna+vCGSHdf2t9OGEICUXHnL
	 L/G/Vis1+LaYr4JOjXm0VhGzZLrUpVF8CAlo+JXX30B5HpXODWaw0nwAMiU9ClhSvIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=gmail.com;
	spf=pass smtp.mailfrom=runbox.com;
	dkim=pass header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=ohbOP0Oc;
	arc=none smtp.remote-ip=185.226.149.38
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD52760A260B;
	Wed, 11 Nov 2026 11:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD52760A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=runbox.com header.i=@runbox.com header.a=rsa-sha256 header.s=selector1 header.b=ohbOP0Oc
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xR6zL-001rxA-Hv; Wed, 11 Nov 2026 12:59:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=F42lcRumFDtpy3odmo1wxO6UuJDNkbkiUxHz5CuV8Vk=; b=ohbOP0OcsQeckpTjAtxhAvWslR
	09SnYRqOihVRU5Ui497PvvRT/OiMoyIAhzzB/NJoYWZ71TOdDvAosV1RjXVO3Do9rxRuoXOZG/+sO
	GzMRnnZXhFJdn2ozHqGM1sucGPgBFPcfbdnne4H2V15KGgaiZ2aTCFt0GTYNsKIDSWKpYrdKd2xaR
	+VuHSVl/BuWovCYu7Wj+8pm2R9oUkQ36hJcqiZMP8cE5MpH38zsvxRY38zZz4vJ1h238/P42391BA
	AsPtJ7bqq61gczm1V4pukTFNiMfU7/jCKfCDIwRtrtGFuHTiEow0mt+dOrybJmHMUr7ATExRP/dQs
	rzeVh1Gw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1xR6zG-0000Ub-2H; Wed, 11 Nov 2026 12:59:34 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xR6z5-001mRM-TG;
	Wed, 11 Nov 2026 12:59:24 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Petr Mladek <pmladek@suse.com>,
	Kees Cook <kees@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Samuel Wu <wusamuel@google.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 next 03/13] scripts/elf-parse: add elf_map_big_endian() helper
Date: Wed, 11 Nov 2026 11:59:01 +0000
Message-Id: <20261111115911.1142000-4-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261111115911.1142000-1-david.laight.linux@gmail.com>
References: <20261111115911.1142000-1-david.laight.linux@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Returns 1 for big-endian, 0 for little-endian.
While the tools are compiled for a specific architecture the target
endianness isn't easily obtainable.

Use 'const Elf_Ehdr *ehdr' for the argument, change the argument of the
very similar elf_map_machine() and elf_map_long_size() to be the same.
All the callers either pass the correct type or 'void *'.

Will be used by kallsyms.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

New patch for v3.

 scripts/elf-parse.c | 13 +++++++------
 scripts/elf-parse.h |  5 +++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/scripts/elf-parse.c b/scripts/elf-parse.c
index ce1c2a670244..24d99ab9adc0 100644
--- a/scripts/elf-parse.c
+++ b/scripts/elf-parse.c
@@ -170,20 +170,21 @@ static int elf_parse(const char *fname, void *addr, uint32_t types)
 	return 0;
 }
 
-int elf_map_machine(void *addr)
+int elf_map_machine(const Elf_Ehdr *ehdr)
 {
-	Elf_Ehdr *ehdr = addr;
-
 	return elf_parser.r2(&ehdr->e32.e_machine);
 }
 
-int elf_map_long_size(void *addr)
+int elf_map_long_size(const Elf_Ehdr *ehdr)
 {
-	Elf_Ehdr *ehdr = addr;
-
 	return ehdr->e32.e_ident[EI_CLASS] == ELFCLASS32 ? 4 : 8;
 }
 
+int elf_map_big_endian(const Elf_Ehdr *ehdr)
+{
+	return ehdr->e32.e_ident[EI_DATA] ==  ELFDATA2MSB;
+}
+
 static void *__elf_map(char const *fname, size_t *size, uint32_t types,
 		       bool writable)
 {
diff --git a/scripts/elf-parse.h b/scripts/elf-parse.h
index c5ad754da254..72c78da5cb3a 100644
--- a/scripts/elf-parse.h
+++ b/scripts/elf-parse.h
@@ -318,8 +318,9 @@ static inline void w8le(uint64_t val, uint64_t *x)
 void *elf_map(char const *fname, size_t *size, uint32_t types);
 void *elf_map_ro(char const *fname, size_t *size, uint32_t types);
 void elf_unmap(void *addr, size_t size);
-int elf_map_machine(void *addr);
-int elf_map_long_size(void *addr);
+int elf_map_machine(const Elf_Ehdr *ehdr);
+int elf_map_long_size(const Elf_Ehdr *ehdr);
+int elf_map_big_endian(const Elf_Ehdr *ehdr);
 
 /* A mapped file with its section headers, section names and symbol table. */
 struct elf_file {
-- 
2.39.5

