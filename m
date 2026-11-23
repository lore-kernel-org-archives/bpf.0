Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434306;
	b=YxBDV0QMLEIr5PCnOoCzMwl1aD27HOhrd0tBsYTk0uex8jKYs+wGI6LMV+VcoQMhLZ9J
	 e7s1H/VzgSAY+V6IXWWCwDBZFQTKI8zqlwea+BMvZntZPlXAnZCrHDkt8J2lU1jNdws/i
	 rEy6ju8kpo+bkDZJRI9FtehcT7b/BPT17hMpYpw0dQF+YxeDrVMM5dE6+//jObaHJ2klR
	 G9tJEs5RUe18WVOGjd9oshc/G03BnqUHxD/8yk7TNttkM6JWODPqPoYGgkfauLgTvgPbK
	 GsfPjqQehUsLzSHd1uo+v6LfgzxeYt5NC/ZKl0/3Qz/yX8AvE14had4sP2U88CeGGwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pVqS5lS0RoTOTBL4CoDpn/qs9ZBbwa0oy02KVDKJZu4=;
	b=2XbZZitTBP5P+LKDtMzDnrz20QUE55X+274YsWmktS2ovIVXf2w731F7rT8cJQQipKZZ
	 iH7guzT51w1nySq94aeRveXHAVd8CJD+cVogUtJfA6wYihzR1y5qFfM918XliVQswegDg
	 26GCtbUeF/D6KjgOJOPMW25U/CWTJqqH/IfC1AJvkOUoC2myyklYSymhSvReqCUqRJfyF
	 kH7GAy7+onh9BIMLQtEYbdj4VKYPnaJj6RmUXJ3/7lxELRvQqwVxqD5r2E+xEOJ6rVeea
	 SV+AzVC1OAjbB9XsqeopoFjpjOoNb1cYmQl6ldTyQH04lGapjcKkktSbcZWlvXYfKrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=armoriq.io;
	spf=pass smtp.mailfrom=armoriq.io;
	dkim=pass header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YHJMp8Bm;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5423A606A32A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 11:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5423A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armoriq.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armoriq.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=YHJMp8Bm
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36a315ed211so4074373eec.0
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 03:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=armoriq-io.20260707.gappssmtp.com; s=20260707; t=1795434305; x=1796039105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pVqS5lS0RoTOTBL4CoDpn/qs9ZBbwa0oy02KVDKJZu4=;
        b=YHJMp8Bmk8/Y5UGI3WO+C/4G37ilVZeCpz7VnZ7ZI2IEqbBuGcd/bi+hG2XsQHt0u7
         um+s77GVp+2kloGsHhii9lNheqXIJCDiWwoYZG38b3ObmOX4hBZ0pYvhqgAorDSuz1n9
         roxIut84FpOVTZ4fqXz+GvpsVZxTIycJSxLESdALF462vjsH2nqeASBtJr4ZWVNM0qgr
         gT/KLKX8kxCCh0S1zIh3TIdwb3XU/uJYwxtVIGxau2qZTdn5ztZMfTG/C9uru6fQimLZ
         Fh0iyxte36lYEhK1do5rJtSxdFpMh5s6nMhI8OITJZ+WoWcqjfyqesDbAqJRyImOmISc
         Y/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795434305; x=1796039105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pVqS5lS0RoTOTBL4CoDpn/qs9ZBbwa0oy02KVDKJZu4=;
        b=H3GJj8PihsbGHRg0nowM0TbNJPZmLFThE9eE3alBs1POM0AUCvCpqRuudCrIpMOkei
         BkTMBox9Gon3lMwX5yvZPHDtae1GvO7jb/uxrx3IN9r5SgzMycNH+2AHvRzw9XVAUPiw
         hilSOCNVdW3w6AmNvD3m9DwaxeNcArzkoy5rnc6RvjHEEyy8h9nsbqTV354eJTnmOTVm
         pcF4jk3g0WOSfJiE52+uBsQBoPqSb6wF7PssnCRBKps4e1LxOAHvuyxCcWdw+D5U+CkQ
         2+oqGoHEylyWj1ZxdNm+7MHByQX3a+Hp5ERtA1vLisvN3PpcL5lzcH8fQhavw3eggeZe
         yvpg==
X-Gm-Message-State: APuU4Z/tl7hqE9d7vaiFDmBVPGFbXpMWG7//Vd1Y56Y0dUw/3RZTC9P8
	Mca8M4uIvyi9fJ+Cngx4v/Cvor15/cArL1TBcgcJrqUDQRmykWSA7TP19PMJMWMLacBzWHmJNmd
	tTmPDFzJI
X-Gm-Gg: AZFdTZc0DIVmdZiudazH1BSJzHfV3H9+PfodW8hoSuIBiLncw8xNndMMy0/sO0dyGjo
	XAxMY82SdyygerolSgvQ5EXbwqxeUl0qETJ+WhKrluy9SPCzDT6E3xXgkZ6roo7EbbfHFrb+KHx
	NcdcVanK+gtB1/oyIwVTNZ6YLqwDgYjSKE1J5dAwmcBCaDIJtA0S4sqZddp0DnNncDWHjP5P9e9
	LjhmoHQqEdIxlHLD5jk6RvbPjXarw9ABn0rZqnlNtSmNztYm7JW+g3DuW3f3M7QAkV4DYK8eY+S
	AWmsZJTjAIu3rMKAwKBGf3ETBQ/r4Pc4UbTivUuZz4fwzi1B4p1+yr6h4WKPKCL6s6IxS34yuKG
	CQ1DN4fADbLlIg2IRcDjpqz7DVA+aGxYbbNb2jUf2efD4B9NKlyt0HTczRSNet+B/3t/DGfqGDG
	PpwsCZV+tyqrwR41IbgGDEFEkmpS9SXAlRgOZO8+VBbVC85ahx5kQUJJRUq73SXIViGv96OBdUL
	niq61tniHtwNKON4+Z+tY+wuMR9gJqHXbFasmS3EUCbRhZHyaQKvq5xM7jDrAZTs4XSVkNtJbK2
	s6Ov5hhVZuXQnU6lsW9vp+G+ybCgc1AWgc+TUV/hhwQoYHI/rPyEZdofPAfyuh/niR9yP6KH/T8
	nPMLiaplAz53o7ENnyOCNUY7FcmnMMMgIQ7xCOc60UVF5vz5qFKzkng==
X-Received: by 2002:a05:7301:4283:b0:386:96fb:28c with SMTP id 5a478bee46e88-38696fb2022mr9810486eec.18.1795434305311;
        Mon, 23 Nov 2026 03:45:05 -0800 (PST)
Received: from localhost.localdomain ([2409:40f4:14e:94e0:654e:d7ff:13d2:447d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm41943583eec.10.2026.11.23.03.44.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 03:45:05 -0800 (PST)
From: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>
To: bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org
Cc: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>,
	"Liam R. Howlett" <liam@infradead.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Segall <bsegall@google.com>,
	David Hildenbrand <david@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Morris <jmorris@namei.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kees Cook <kees@kernel.org>,
	Ketan Bhardwaj <ketan@armoriq.io>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: [RFC PATCH v4 6/6] MAINTAINERS: add an entry for the Kernel Assurance Plane
Date: Mon, 23 Nov 2026 17:13:08 +0530
Message-ID: <20261123114308.8103-7-harisudhan@armoriq.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123114308.8103-1-harisudhan@armoriq.io>
References: <20261123114308.8103-1-harisudhan@armoriq.io>
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

Add the KAP maintainers and the files they look after.

Assisted-by: Claude
Co-developed-by: Ketan Bhardwaj <ketan@armoriq.io>
Signed-off-by: Ketan Bhardwaj <ketan@armoriq.io>
Signed-off-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f53047aa8..0946d151e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14118,6 +14118,16 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media.git
 F:	drivers/media/radio/radio-keene*
 
+KERNEL ASSURANCE PLANE (KAP)
+M:	Ketan Bhardwaj <ketan@armoriq.io>
+M:	HARIHARA SUDHAN. R <harisudhan@armoriq.io>
+L:	linux-security-module@vger.kernel.org
+S:	Supported
+F:	Documentation/ABI/testing/securityfs-kap
+F:	Documentation/security/kap.rst
+F:	include/linux/kap.h
+F:	security/kap/
+
 KERNEL AUTOMOUNTER
 M:	Ian Kent <raven@themaw.net>
 L:	autofs@vger.kernel.org
-- 
2.43.0

