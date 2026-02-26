Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21438BF75
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088928; cv=none; b=mhtQarQQA2xvluOTMnH3WrUWtZsvtcjV2PuPrfJJDODRDjyx+CQcR/VK6DmZT+p9XToGg0Llcfujlnv4jAaq35Br8Mumd1Tn4JMEuPdxwnzFO1VwmT9O0hetA8OEufVjxCCevXMf/LsVCfujA8F6zMUZgNf9TAirZ5E6TdwgjV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088928; c=relaxed/simple;
	bh=x9pHIVLArzt272u1yZLZ0GewsdFyxBVKY9w5joDth3A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aJ0jYlG2WDleMhESQ1fYrvTvwyNfunkt4MhQOpUn9rXzwPkD2t2uvaG8eMEQhIllR0tGo7AQSC+Zoiqr5adLjzo1AZ4YGAsS6GYhpBEPG1Q/HwpLtYU5aL4sLmbcxz0LTC10CFlUQH1jPiqOv70KKiX2kaSKtii1fg5nfNMsfLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KXGbo7Fi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KXGbo7Fi"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q5Zgso2236900;
	Thu, 26 Feb 2026 06:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uWyBre
	fH+ORzt5V7gbI1UY7SXQfbZSHGO5+cTdOyT8I=; b=KXGbo7Fi3RvTsjTAg7Z7Zn
	CnEaR24xsXgoZUilIMFRyNBaZQ5zZ/UhIjvbU5gl5E7Klweb/U3cJTEB9NyZrBET
	jWL1yGmdW1qG9rujI+wFbCnkXZKt11ebLJDFhhgmjr5mQbtLM6oRYW3BIaZhxzSV
	/Y5Ng8Ozzl12Hwv7VJS6MnkLLr3o3ZKqZlQGcpq95Julir2IH962ZqqO7VudF6HS
	A0oHkldWLbDJF0N4Wx7jKz1lcOTBo5EsQe95KU1Nj5ubFiblJVzH3CMpW4GyOg3H
	UKWN7SLkhNuOTrmamHF92ss8rEaOcQWcm7i2Mj/HetMcMPwWJaTmTog84GZylmzg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4bs3wxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 06:55:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q6drcJ015750;
	Thu, 26 Feb 2026 06:55:05 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1ssve6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 06:55:05 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61Q6t4v730999288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 06:55:04 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F20958059;
	Thu, 26 Feb 2026 06:55:04 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DDB258063;
	Thu, 26 Feb 2026 06:55:01 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.98.108.141])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 26 Feb 2026 06:55:01 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v4 2/2] selftests/bpf: Enable private stack tests for
 powerpc64
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20260226031324.17352-2-adubey@linux.ibm.com>
Date: Thu, 26 Feb 2026 12:24:48 +0530
Cc: linuxppc-dev@lists.ozlabs.org, bpf@vger.kernel.org, hbathini@linux.ibm.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        maddy@linux.ibm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0D287760-5EE6-4F98-A91A-DA018BCAC3CB@linux.ibm.com>
References: <20260226031324.17352-1-adubey@linux.ibm.com>
 <20260226031324.17352-2-adubey@linux.ibm.com>
To: adubey@linux.ibm.com
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _pVcov_Pi0gbNYt9Rg6SyY6a_i_Bg2TJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA1NyBTYWx0ZWRfX6sjrETOrVyTr
 cl2ri6xJq2U4FMdU/yFzbatx2/PhUHXS5awbQTsfzCbqugw5Gkx+hvRiZBGoMQ7BYpanuFiefbM
 lNEaz/rqdE+5CroBVnkbcqBlBBeSRpD+Mru4T8f9k//NJaNR3NKfdubzsl9Mi7slQNIafyKYAGv
 ebQAveCNwAdRn3QsWxqCMy64dUq5Cr2HnJ2b8pGwx6bAldNn1cv3RGuztkwYbC0aPn2Y6LyAjJC
 kgQdfWBa230nKpa8U6kDmvi/wMsFMCcal/yCA4VLSVmNJK0Ep2f2wcoEGSG5THk7YE0diwT6lA/
 Txsbc0jdVnYPcSuMgPciTjIKLDyIIV+FE869oHRMi5G8/rveMKRz2AXrCXg8hpwP2Azn0KaUJNt
 Vs/F4CQFzR7d6UPNXMkxBRkKs9OdHc+ULaOZ+4FYvZ1/xUQTiCCrD9eTKgU4o1sHw6Ki53vF9C0
 KQTrs5Vn47Znu6KDJCg==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=699fee4a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=3ngUbzHfdUlpjFJBK1YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _pVcov_Pi0gbNYt9Rg6SyY6a_i_Bg2TJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260057



> On 26 Feb 2026, at 8:43=E2=80=AFAM, adubey@linux.ibm.com wrote:
>=20
> From: Abhishek Dubey <adubey@linux.ibm.com>
>=20
> With support of private stack, relevant tests must pass
> on powerpc64.
>=20
> #./test_progs -t struct_ops_private_stack
> #434/1   struct_ops_private_stack/private_stack:OK
> #434/2   struct_ops_private_stack/private_stack_fail:OK
> #434/3   struct_ops_private_stack/private_stack_recur:OK
> #434     struct_ops_private_stack:OK
> Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
>=20
> v2->v3:
>  Enable testcase using __powerpc64__ instead of __TARGET_ARCH_powerpc,
>  to prevent it getting invoked on powerpc32
>=20
> [v2]: =
https://lore.kernel.org/bpf/20260225153950.15331-1-adubey@linux.ibm.com
>=20
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>

./test_progs -t struct_ops_private_stack
#440/1   struct_ops_private_stack/private_stack:OK
#440/2   struct_ops_private_stack/private_stack_fail:OK
#440/3   struct_ops_private_stack/private_stack_recur:OK
#440     struct_ops_private_stack:OK
Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED


Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat.
> ---
> .../bpf/prog_tests/struct_ops_private_stack.c | 29 +++++++++----------
> .../bpf/progs/struct_ops_private_stack.c      |  6 ----
> .../bpf/progs/struct_ops_private_stack_fail.c |  6 ----
> .../progs/struct_ops_private_stack_recur.c    |  6 ----
> 4 files changed, 13 insertions(+), 34 deletions(-)
>=20
> diff --git =
a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c =
b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> index 4006879ca3fe..afad3522b772 100644
> --- =
a/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> +++ =
b/tools/testing/selftests/bpf/prog_tests/struct_ops_private_stack.c
> @@ -5,6 +5,7 @@
> #include "struct_ops_private_stack_fail.skel.h"
> #include "struct_ops_private_stack_recur.skel.h"
>=20
> +#if defined(__x86_64__) || defined(__aarch64__) || =
defined(__powerpc64__)
> static void test_private_stack(void)
> {
> struct struct_ops_private_stack *skel;
> @@ -15,11 +16,6 @@ static void test_private_stack(void)
> if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack__open"))
> return;
>=20
> - if (skel->data->skip) {
> - test__skip();
> - goto cleanup;
> - }
> -
> err =3D struct_ops_private_stack__load(skel);
> if (!ASSERT_OK(err, "struct_ops_private_stack__load"))
> goto cleanup;
> @@ -48,11 +44,6 @@ static void test_private_stack_fail(void)
> if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack_fail__open"))
> return;
>=20
> - if (skel->data->skip) {
> - test__skip();
> - goto cleanup;
> - }
> -
> err =3D struct_ops_private_stack_fail__load(skel);
> if (!ASSERT_ERR(err, "struct_ops_private_stack_fail__load"))
> goto cleanup;
> @@ -72,11 +63,6 @@ static void test_private_stack_recur(void)
> if (!ASSERT_OK_PTR(skel, "struct_ops_private_stack_recur__open"))
> return;
>=20
> - if (skel->data->skip) {
> - test__skip();
> - goto cleanup;
> - }
> -
> err =3D struct_ops_private_stack_recur__load(skel);
> if (!ASSERT_OK(err, "struct_ops_private_stack_recur__load"))
> goto cleanup;
> @@ -95,7 +81,7 @@ static void test_private_stack_recur(void)
> struct_ops_private_stack_recur__destroy(skel);
> }
>=20
> -void test_struct_ops_private_stack(void)
> +static void __test_struct_ops_private_stack(void)
> {
> if (test__start_subtest("private_stack"))
> test_private_stack();
> @@ -104,3 +90,14 @@ void test_struct_ops_private_stack(void)
> if (test__start_subtest("private_stack_recur"))
> test_private_stack_recur();
> }
> +#else
> +static void __test_struct_ops_private_stack(void)
> +{
> + test__skip();
> +}
> +#endif
> +
> +void test_struct_ops_private_stack(void)
> +{
> + __test_struct_ops_private_stack();
> +}
> diff --git =
a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c =
b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> index dbe646013811..3cd0c1a55cbd 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_private_stack.c
> @@ -7,12 +7,6 @@
>=20
> char _license[] SEC("license") =3D "GPL";
>=20
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> -bool skip __attribute((__section__(".data"))) =3D false;
> -#else
> -bool skip =3D true;
> -#endif
> -
> void bpf_testmod_ops3_call_test_2(void) __ksym;
>=20
> int val_i, val_j;
> diff --git =
a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c =
b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
> index 3d89ad7cbe2a..1442728f5604 100644
> --- =
a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
> +++ =
b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_fail.c
> @@ -7,12 +7,6 @@
>=20
> char _license[] SEC("license") =3D "GPL";
>=20
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> -bool skip __attribute((__section__(".data"))) =3D false;
> -#else
> -bool skip =3D true;
> -#endif
> -
> void bpf_testmod_ops3_call_test_2(void) __ksym;
>=20
> int val_i, val_j;
> diff --git =
a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c =
b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
> index b1f6d7e5a8e5..faaa0f8d65a4 100644
> --- =
a/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
> +++ =
b/tools/testing/selftests/bpf/progs/struct_ops_private_stack_recur.c
> @@ -7,12 +7,6 @@
>=20
> char _license[] SEC("license") =3D "GPL";
>=20
> -#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
> -bool skip __attribute((__section__(".data"))) =3D false;
> -#else
> -bool skip =3D true;
> -#endif
> -
> void bpf_testmod_ops3_call_test_1(void) __ksym;
>=20
> int val_i, val_j;
> --=20
> 2.52.0
>=20

