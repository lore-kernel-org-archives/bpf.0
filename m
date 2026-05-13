Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97EA3B777B
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778700942; cv=none; b=a7P/n17Ahl6cUvFJMsDuOcxVRr7qScFFk3WSmlsLog8H0E3BwIoD7B20PmqF7wOS+Pd0VM56o0dtayoHZ7IrD24dzbvx5LdW9DV7WTE9wTVQjwUl7ScYi5ubbjbswWMDT87ibbNMctUWj5MjIHA/+ZpWwhOycXbrEXcx5/Sgtt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778700942; c=relaxed/simple;
	bh=8S5sXkccwzsGxX+Y9QrSgzjHU4EpmBZcYp82acgaOCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/z+dK6BOe6etDExyRNBBpu7lsbkIGdXvNmUe5Vb2YwQ4iIITHby1B2ygtNJuGmlnplhBlvHtUNbCTevAL+iR+D+DZSmWLzzVRvreJ0nYABYvM1uzj8ikFpZFJE4pyntISBMLFvwj4ruYQA8U+Ktddfcx0Ya7aje3iv8dArEPqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebUUOWv2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebUUOWv2"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso49147425e9.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 12:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778700939; x=1779305739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jHdSeehgFlJsnOsvPPWfixOjGYWAtf1bjLBK+56CFa0=;
        b=ebUUOWv2z6Bb/bKhHtAsaPPcpQHoEs5E048dBG3+P01rABXV/jm9djAnt4KThw87Mu
         zOaTpsNZmOYyLnZTcZMvfsr5IR3EC7QHUTprnSamiK/lPqcE3HG4EFoXG0yjsyWlFLPy
         QLbrE50RjAYRgn06PCF+HgE5RM7wDKY/Sg8EsLZrvMs1ttIPgzm6XNa2z+NcTUI6o4ZD
         gGnf6o8EauyuTnT6sAY2IAX2MVf76JPVnrPnYiytH2BB40Pm5GUdRqua7dyl1TSv6G0m
         tlXTpPTdsmC6Y8bhewn/IraD9KxhSH40It1hsADPxsYvv/vFt42QY8ERy17E7YeMZntI
         mT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778700939; x=1779305739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHdSeehgFlJsnOsvPPWfixOjGYWAtf1bjLBK+56CFa0=;
        b=IPtqdKVg2XdG/0KzkyXXs9oNcaYAr+cH05+KTAKKhbWWjBkvucKm0NZ6r8j1Dsyiul
         E6il/30uN8lh+RGUIWP2bKoJhbuwi62cHTiaLavyRZx068X4laakr6lOysuhpEWULsqV
         trcWuv9lyRa//dKgE1m06PvtqUa1pluRwPaIZsKgSBHYd776oI2lhofBI6g3lrUGFi0l
         TULSKtgn+j0mX2X/UxzkYZ12Wy/3hKv9/uw8K5A51Jm13kpF8EOe6LdOxPvPiBSNosax
         Jfu6tAXhPP8yfv1HncsruhIromO4z26DwMpxDoK4ee7hJBl/W/nRPFta8Jgu0DqeuAnJ
         Qb8Q==
X-Gm-Message-State: AOJu0YyCrnUOlFmNKEW2sUXFqLjMqHyAXp+MRhHmlByXQXBaqSoCBrS/
	IVk9/2Pg1k9PFKMuBIxd6ESWcv0gd6T6egZK0y3VY3q84E4QEg8UIglJMrfU7g==
X-Gm-Gg: Acq92OF3LZKaICC0/r9nUHT7r5c5nLvYD9BhFxWkIIGcD0WeBc92EE4NaEvJK9wtMOx
	5wZHRW+9j6DSNvyrHp+FgSdwTEVqdjSbYcjpprY9A8SIixE0Ghg2r2gulBrn1/eGKUR7x5tch9J
	pC53skvcS29pB/TknTULYYKyRRHs6CEuc2VcbBa2FSyiCtWUUtOsXWwmG+LCxRx6K5Dlk0ShZA8
	hBX72vNNep1dme0azwCAUdhv+FIiP0bFtvXR76UoTxzIckaI1d1LVThY4YO1u6tzfGY7UhGWvCQ
	cubdyNXCFsEPEsMidACUgW4sMJkvO/irps8WnYa0cZ5TMNFPbGxDmwFjwjrucW6dAe7XzturXJB
	5R1KPsduJACX5/6Z4+85iOhEyuuaL0e5W+L0uySdBxYCKbQbmimQEs2qDpCUMlBKXWiCdIJ5aCM
	Ddc0Db2uSAAE13iJiDxDOEbLoSxqBGQWgWyXvtMOI0vtwg6jL6NyyZpAAoj9ZKDJDGC3LXzAkI7
	1Llh4JEYjnp9UzPZE4ggYg/4fUjGyn+PPnYW2hKh+51M6EiDAIga6OETtEpdP1mX6YCnJoiPUQy
	PYNIL/uMQWjc/zVE43GQvSb44YkIsoY2uzTb3/RZ5dL/Aye0JC8DFg==
X-Received: by 2002:a05:600c:3107:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48fc9a07765mr67615425e9.5.1778700938685;
        Wed, 13 May 2026 12:35:38 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0055c0fd718e6af73d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:55c0:fd71:8e6a:f73d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd64cebaasm9578785e9.11.2026.05.13.12.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 12:35:38 -0700 (PDT)
Date: Wed, 13 May 2026 21:35:36 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf-next v3 3/3] veristat: Report max stack depth
Message-ID: <a27ed8f336669152c4b1b05e920aee4438e3e2b3.1778700777.git.paul.chaignon@gmail.com>
References: <cover.1778700777.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778700777.git.paul.chaignon@gmail.com>

This patch adds a new "Max stack depth" field to the set of gathered
statistics. This field reports the maximum combined stack depth compared
to the 512 bytes limit. It is null for rejected programs.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 5c82950e6978..a7db6f04f7e1 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -48,6 +48,7 @@ enum stat_id {
 	SIZE,
 	JITED_SIZE,
 	STACK,
+	MAX_STACK,
 	PROG_TYPE,
 	ATTACH_TYPE,
 	MEMORY_PEAK,
@@ -789,13 +790,13 @@ static int append_file_from_file(const char *path)
 }
 
 static const struct stat_specs default_csv_output_spec = {
-	.spec_cnt = 15,
+	.spec_cnt = 16,
 	.ids = {
 		FILE_NAME, PROG_NAME, VERDICT, DURATION,
 		TOTAL_INSNS, TOTAL_STATES, PEAK_STATES,
 		MAX_STATES_PER_INSN, MARK_READ_MAX_LEN,
 		SIZE, JITED_SIZE, PROG_TYPE, ATTACH_TYPE,
-		STACK, MEMORY_PEAK,
+		STACK, MAX_STACK, MEMORY_PEAK,
 	},
 };
 
@@ -834,6 +835,7 @@ static struct stat_def {
 	[SIZE] = { "Program size", {"prog_size"}, },
 	[JITED_SIZE] = { "Jited size", {"prog_size_jited"}, },
 	[STACK] = {"Stack depth", {"stack_depth", "stack"}, },
+	[MAX_STACK] = {"Max stack depth", {"max_stack_depth"}, },
 	[PROG_TYPE] = { "Program type", {"prog_type"}, },
 	[ATTACH_TYPE] = { "Attach type", {"attach_type", }, },
 	[MEMORY_PEAK] = { "Peak memory (MiB)", {"mem_peak", }, },
@@ -1023,7 +1025,7 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
 				&s->stats[MARK_READ_MAX_LEN]))
 			continue;
 
-		if (1 == sscanf(cur, "stack depth %511s", stack))
+		if (2 == sscanf(cur, "stack depth %511s max %ld", stack, &s->stats[MAX_STACK]))
 			continue;
 	}
 	while ((token = strtok_r(cnt++ ? NULL : stack, "+", &state))) {
@@ -2278,6 +2280,7 @@ static int cmp_stat(const struct verif_stats *s1, const struct verif_stats *s2,
 	case SIZE:
 	case JITED_SIZE:
 	case STACK:
+	case MAX_STACK:
 	case VERDICT:
 	case DURATION:
 	case TOTAL_INSNS:
@@ -2512,6 +2515,7 @@ static void prepare_value(const struct verif_stats *s, enum stat_id id,
 	case MAX_STATES_PER_INSN:
 	case MARK_READ_MAX_LEN:
 	case STACK:
+	case MAX_STACK:
 	case SIZE:
 	case JITED_SIZE:
 	case MEMORY_PEAK:
@@ -2602,7 +2606,8 @@ static int parse_stat_value(const char *str, enum stat_id id, struct verif_stats
 	case SIZE:
 	case JITED_SIZE:
 	case MEMORY_PEAK:
-	case STACK: {
+	case STACK:
+	case MAX_STACK: {
 		long val;
 		int err, n;
 
-- 
2.43.0

