Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF1034BA42
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005059; cv=none; b=theKU0tS8of2mcBm9EGVx2WTxjdFHQpdpWJXlMRrIzJYB7ShAmcHc9twwMKa4UoTMU4K1szRywQD/n83NbBZa97a0XK61SX9VEprlAT1ofOUX9k0v1NX7Xluh08yW3R7gfiSbzd1eDOpJUSTg2VIVBYrEsDOylv3Ji2lURHZnvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005059; c=relaxed/simple;
	bh=bhElH86Ym0WcoYVvBIDYuFLe+1SsmUk5YHtDDwTymuo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Xt4E8SFZ+Dhp/MJvOQ+NJP5RixCNWqK8GP/GHYXquV9P6fJDV/YJ3uVtm5KxE9M6WZoPqMl6w/4y8JWAqOeQy5dE2RV/PVQP2RE/yXQ66VxGl28qu/GQ3/qYF+C2ZS2I0jluH1zA8W7MCDMXhnJ0MI4DSd70XoXho4aV0zm98Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=ABzpJggT; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="ABzpJggT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1781005047; x=1781264247;
	bh=sV70FGG+4hB2Tz+hecc1yNZgXa1RZHILfqNcAF3boPw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ABzpJggTqGRBhOxcqD6Xulx6RXN3rsN8MP8gckYBUzTfXZ2flXy30xGNM6yjMy+7G
	 d9EnmUNsxbrcMLoT8Q/ayEMwi0qE5XzXSo5MaoE1Gb/Pk9WjLwpxHAY73X9wYUzczS
	 j3PzglgvEtBdrpgVaTZF/o+oDk1flhCoFW70Lae36xhhBjmRL2hAL/nR2LiOOeaXwm
	 /IEtk08Kq8tSIO+Z/sDfwbUVqhLaaK0UOwj/MhCs4IGvT+26dO4NnUJ9SKoRazgBRS
	 EBMS707jC3KVjJSXxbYGtVMLXfvyKDkZZqyih3j7go3YfQ+OZK8nkkS+tos724Wozh
	 lfRKtFi6hCRhg==
Date: Tue, 09 Jun 2026 11:37:18 +0000
To: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, bpf@vger.kernel.org
From: Paul Moses <p@1g4.org>
Cc: song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, houtao1@huawei.com, linux-kernel@vger.kernel.org, Paul Moses <p@1g4.org>, stable@vger.kernel.org
Subject: [PATCH bpf] selftests/bpf: Add BTF repeated field count overflow test
Message-ID: <SzebdWqm2zREZBf8Tc5Kc-JDWbh9nBztnk4PUu5kRSD1OOdr_ESVTt__2Hd3-lClr47jIjJCXfOH0RHsMpjjpEUh_R2v30nh3T1IXNT6Pbo=@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 24eacd20e2a8b62a6a540ebe24527b428b81841e
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From 7129e266643883a4f83e65fce3ce20c7f7269fb3 Mon Sep 17 00:00:00 2001
From: Paul Moses <p@1g4.org>
Date: Tue, 9 Jun 2026 05:08:54 -0500
Subject: [PATCH bpf] selftests/bpf: Add BTF repeated field count overflow t=
est

Add a raw BTF test that exercises repeated special-field expansion with a
large array count. The compact element layout keeps the array byte size
representable while the repeated field count overflows the old u32 capacity
calculation in btf_repeat_fields().

Signed-off-by: Paul Moses <p@1g4.org>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 37 ++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/s=
elftests/bpf/prog_tests/btf.c
index 054ecb6b1e9f..9fcbc554e351 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -4258,6 +4258,43 @@ static struct btf_raw_test raw_tests[] =3D {
 =09.max_entries =3D 1,
 },

+{
+=09.descr =3D "struct test repeated fields count overflow",
+=09.raw_types =3D {
+=09=09BTF_TYPE_INT_ENC(NAME_TBD, BTF_INT_SIGNED, 0, 32, 4),=09/* [1] */
+=09=09BTF_STRUCT_ENC(NAME_TBD, 0, 0),=09=09=09=09/* [2] */
+=09=09BTF_TYPE_TAG_ENC(NAME_TBD, 2),=09=09=09=09/* [3] */
+=09=09BTF_PTR_ENC(3),=09=09=09=09=09=09/* [4] */
+=09=09BTF_TYPE_ARRAY_ENC(4, 1, 1),=09=09=09=09/* [5] */
+=09=09BTF_STRUCT_ENC(NAME_TBD, 10, 8),=09=09=09/* [6] */
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 5, 0),
+=09=09BTF_TYPE_ARRAY_ENC(6, 1, 0x1999999aU),=09=09=09/* [7] */
+=09=09BTF_STRUCT_ENC(NAME_TBD, 2, 8 + 8 * 0x1999999aU),=09/* [8] */
+=09=09BTF_MEMBER_ENC(NAME_TBD, 4, 0),
+=09=09BTF_MEMBER_ENC(NAME_TBD, 7, 64),
+=09=09BTF_END_RAW,
+=09},
+=09BTF_STR_SEC("\0int\0prog_test_ref_kfunc\0kptr_untrusted\0elem"
+=09=09    "\0p0\0p1\0p2\0p3\0p4\0p5\0p6\0p7\0p8\0p9"
+=09=09    "\0outer\0trigger\0elems"),
+=09.map_type =3D BPF_MAP_TYPE_ARRAY,
+=09.map_name =3D "repeat_fields",
+=09.key_size =3D sizeof(int),
+=09.value_size =3D 8 + 8 * 0x1999999aU,
+=09.key_type_id =3D 1,
+=09.value_type_id =3D 8,
+=09.max_entries =3D 1,
+=09.btf_load_err =3D true,
+},
 }; /* struct btf_raw_test raw_tests[] */

 static const char *get_next_str(const char *start, const char *end)
--
2.54.0


