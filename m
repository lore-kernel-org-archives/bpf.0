Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443921;
	b=J3P4zHjGNHQcnfBC7kobRFVVBUY37zDcTrp1i2CAJ/O1wRp/d1WGg3yJwiopdcRuJybc
	 pFKIO5Jj/iTjFlHA1PLhWJP/iSD7a1pc2lBZ6QOHZ075dvl+77VRHKu33HoJmPp9EOK5H
	 TXmsyw6tq4rxjVbx1g6F9Y1pikMzTZ7HLCAHjKZetq8A3rA7Qb9K2VxsUvgsmHonX/KeO
	 PNC9d0LoGSjPzXc2GmU0HTka+nF16W7Nkt3aPmgT9K8yGSnT49MJrZoaxvf9Rh1WpdAn7
	 egF/SBIvgAdidf8TbbTdVoXi01c3UnKm66tEtP7H0b8wGLr+WSksbq6aKg3g5OYvucg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443921;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=OqbI/RShFB8T0Zp0UOGmfW3WUkVldP/5W80D6kbadD8=;
	b=QpBx7ljsRtujGhdT+Ig3/CeYaTqNLnSQc/fUuFXja3YPjBvEGf1fZjHGXF5gVoIAYoUe
	 aSWsFUa3jXiCFir5tGyamQd/c1PEXjlLFPA6AiaeAFaHorzfYx2LxteptQWrVliRjfgVI
	 Ocf8jcZrgmidTjKHV5YG/PyLAx0+ti1zDiJ1Li9t4plWC8hWHGZ7JwGbXmzmNtRjp71m2
	 ERwI/gu/ZJegi5HfmHJr/fBZXbd6VoqCKNpKxqXa8jFVKdTmJk+1WiVckoIYmXbDV0TAj
	 G14MehY0a2qvF9z56XSQNRZinnRMz3cPk2lYhBEvTxMVuCsYCjrKQEoL8QCIPaQGK4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMi1qS7k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283C6606A31A;
	Mon, 23 Nov 2026 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMi1qS7k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00771F000E0;
	Mon, 23 Nov 2026 14:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795443920;
	bh=OqbI/RShFB8T0Zp0UOGmfW3WUkVldP/5W80D6kbadD8=;
	h=From:To:Cc:Subject:Date;
	b=QMi1qS7ks8YHRdcH5cBWyPEwTEymkPBzm2gx/KB7qIaFcwjG4h0Tk8a9sYIcRg4FY
	 4VI1fgp9vkGirB9imtfxrf99CEeDRR51pLZgddjoRgSOtvAyTvzBANbA47xMA7BX9y
	 5ipESK9e6fyzrPOdOzRGtr0z+hKbttYbP4MkQJkpLJTtEXcOUqCl7NO0NVaE9teQSx
	 5mjclgwWi4jEFaV/lZ3Bn5Gq6IShexQPkyUkwkmy9YqfXc7WtukN4XmCuhqSzD4Yfd
	 rFHn533Yh+WTLxlbUglxrnWDGOKpxwsT4W6iQJYzryB0vb3I0MGaSbzeiBNguO2ome
	 N177c3bDrOLdw==
From: Thorsten Blum <blum@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>
Cc: Thorsten Blum <blum@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] lib/buildid: Prevent overflow when aligning ELF note sizes
Date: Mon, 23 Nov 2026 15:25:10 +0100
Message-ID: <20261123142510.51241-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=blum@kernel.org; h=from:subject; bh=ubVwu/bFB5b3v5wG+1ppULwvc2EMn6ABkOWV2FeBRUc=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDNksPse02ybeZbSY8j1g5V1/7wP2ypsiTey7jV9oWbm4X Phtlfm/o5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACYy7QMjw/fpkns+7uG6zhdd +WDiohtlMh/3vI9aK9PPqfcgJmFJ6DqGf6anlSquMhfNNVZ7v6n28KpbHycIiWVdnmBhXptaxb5 qOQMA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Commit de3ec364c3c3 ("lib/buildid: add single folio-based file reader
abstraction") changed name_sz and desc_sz from u64 to u32. As a result,
ALIGN() could wrap malformed sizes near U32_MAX to 0, which would allow
such values to bypass the overflow checks and parsing to continue with
an incorrect note offset.

Restore u64 for name_sz and desc_sz to prevent alignment overflow. The
existing check_add_overflow() calls then reject sums that do not fit in
the u32 offset.

Fixes: de3ec364c3c3 ("lib/buildid: add single folio-based file reader abstraction")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 lib/buildid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index 995a327f46ae..767243f424d6 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -161,7 +161,8 @@ static int parse_build_id(struct freader *r, unsigned char *build_id, __u32 *siz
 {
 	const char note_name[] = "GNU";
 	const size_t note_name_sz = sizeof(note_name);
-	u32 build_id_off, new_off, note_end, name_sz, desc_sz;
+	u32 build_id_off, new_off, note_end;
+	u64 name_sz, desc_sz;
 	const Elf32_Nhdr *nhdr;
 	const char *data;
 
