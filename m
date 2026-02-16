Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D123EA93;
	Mon, 16 Feb 2026 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771240166; cv=none; b=NJsUaLwTDX7YTRJjHFA8AU8N1S9kA2L+w+1+xEWEA9sjEJqcWr6pypi06DkxnwcaAjLEeruK3Jm5MvtxzxAtDhHLAH8Lc90WhmgtdwkNj0g/qQJoFdNHn8+iW9HRc6Jl4OovEhLWJWsofuIKt9dTDSU7655bpNKud+aZ49vCX8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771240166; c=relaxed/simple;
	bh=CBtjmTPPNzsWJFITv1aMgfODos7Iz6xuMyIyF8Ps7v0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ACvDKSMbInl4pISkBEwWGQwwprGMAxV/OrGmKSo3pucIBIb4k3BcrvVHhm1XG4r7cAL0B5ad4ivQa6zI3xGDDHsYd+EH1ZW9QXmBaC+kNIGRaNOU3Q3ANdwvzrtEWVqO7gFP2oWPCuJsx2LDXVxU0X0GqNK7BvR2PqgxIgpX8ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sGiTkVXY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sGiTkVXY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FNxMsh3772160;
	Mon, 16 Feb 2026 11:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+ieb5H
	vaem6Z65P96bWU0iQmN7vbp+uPsVJvwS69TKc=; b=sGiTkVXYtMaWOI/SoCizRv
	GiWoknu4LJfj9fB3N8FqaCtEqWbbWg/QDdXMMT7ik9h8OXqipetlURfcIYei/zwV
	IqWqR0lxrhTTal/GJTfi8PjE8JgYihWeur1Ua7irqg4FLga0e07yzxhyodrdvKwQ
	s5iYwqCMZ81Kw5PRxRB4aOCHXHEEnyreVBMMXm9P/2ZoRK9c57hoFNzVkKnz845L
	ZmU3/E8sLEiQAloHix2QH+2lIA1TSjc4+IANSUvBr6IZebx3hZPIY/5utqCzp21G
	eJgkZdnZ1CKURM047U/SzR9TvQxWnBuq6B5NaYFCTNSnygUjLxd7dW98a+yS5UQA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4k6vfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 11:09:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G8I6NW029084;
	Mon, 16 Feb 2026 11:09:10 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb6314ts7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 11:09:10 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GB99xb30016202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 11:09:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0313581EB;
	Mon, 16 Feb 2026 11:09:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA2DB581F0;
	Mon, 16 Feb 2026 11:09:06 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.109.248.127])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Feb 2026 11:09:06 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] selftests/bpf: test accounting of tail calls when prog is
 NULL
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20260216090802.1805655-1-hbathini@linux.ibm.com>
Date: Mon, 16 Feb 2026 16:38:54 +0530
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A7B8B6A-C91D-4322-907E-22E6268F469E@linux.ibm.com>
References: <20260216090802.1805655-1-hbathini@linux.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA5NCBTYWx0ZWRfX0EGYXdy2kucO
 4EuOm4ym5DEXViE414tZSZzfLVIvA4VlhkPhGZ1Xa0LrL6RqjC2sobMY1fc+A4FtKddGpGADRIO
 ApwB64OGmGpUo00Kd+R1sDCVnrcXW4LjWAOPahYDsx0e2VjnBbyhlVxYbL+qXk5qBNDQltPHHIk
 4MMZLAoTFSh+4HHKrpKYrtTXVDH6hlYbWLe0kl/p3cD8OKtMEkOoJ2agTb/+nUhORRtzjJq3R+v
 wMULkMfkXAaGt2d8Vb6JTiKcFkEkJfoup/XVAskIL4YD8R/8cpYsmrma+MKD7LELr7Jf/89iUEN
 utAP5OkiBrMzd6GZ7YkhVym7qT68Mo0Pv/MBqmCdIUgXyOwWUfKaMn6m9+cGkaiZ2/1HLjviyLP
 Jo71EXC8CMEIMPlccKianGmjlthZADj7JMWWbxOhBbHS42KiqIKRi9z8SydE8Vp0NzpVrdcEPmL
 nEN7yqrxZ/nJHTgM3Rg==
X-Proofpoint-ORIG-GUID: VxCacEAIQM3KpX2KCU0-8As1wwvfyc47
X-Proofpoint-GUID: VxCacEAIQM3KpX2KCU0-8As1wwvfyc47
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=6992fad7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=L5kG7fzorW3EaBJoc2gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160094

Hello Hari,

With this patch, tailcalls selftest is failing.

# ./test_progs -t tailcalls
tester_init:PASS:tester_log_buf 0 nsec
process_subtest:PASS:obj_open_mem 0 nsec
process_subtest:PASS:specs_alloc 0 nsec
#448/1   tailcalls/tailcall_1:OK
#448/2   tailcalls/tailcall_2:OK
test_tailcall_count:PASS:tailcall 0 nsec
test_tailcall_count:PASS:tailcall retval 0 nsec
test_tailcall_count:PASS:tailcall count 0 nsec
test_tailcall_count:FAIL:tailcall count unexpected tailcall count: =
actual 32 !=3D expected 33
test_tailcall_count:PASS:tailcall 0 nsec
test_tailcall_count:PASS:tailcall retval 0 nsec
#448/3   tailcalls/tailcall_3:FAIL
#448/4   tailcalls/tailcall_4:OK
#448/5   tailcalls/tailcall_5:OK
#448/6   tailcalls/tailcall_6:OK
#448/7   tailcalls/tailcall_bpf2bpf_1:OK
#448/8   tailcalls/tailcall_bpf2bpf_2:OK
#448/9   tailcalls/tailcall_bpf2bpf_3:OK
#448/10  tailcalls/tailcall_bpf2bpf_4:OK
#448/11  tailcalls/tailcall_bpf2bpf_5:OK
#448/12  tailcalls/tailcall_bpf2bpf_6:OK
#448/13  tailcalls/tailcall_bpf2bpf_fentry:OK
#448/14  tailcalls/tailcall_bpf2bpf_fexit:OK
#448/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:OK
#448/16  tailcalls/tailcall_bpf2bpf_fentry_entry:OK
#448/17  tailcalls/tailcall_poke:OK
#448/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
#448/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
#448/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
#448/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
#448/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:OK
#448/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
#448/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
#448/25  tailcalls/tailcall_freplace:OK
#448/26  tailcalls/tailcall_bpf2bpf_freplace:OK
#448/27  tailcalls/tailcall_failure:OK
#448/28  tailcalls/reject_tail_call_spin_lock:OK
#448/29  tailcalls/reject_tail_call_rcu_lock:OK
#448/30  tailcalls/reject_tail_call_preempt_lock:OK
#448/31  tailcalls/reject_tail_call_ref:OK
#448/32  tailcalls/tailcall_sleepable:OK
#448     tailcalls:FAIL

All error logs:
tester_init:PASS:tester_log_buf 0 nsec
process_subtest:PASS:obj_open_mem 0 nsec
process_subtest:PASS:specs_alloc 0 nsec
test_tailcall_count:PASS:tailcall 0 nsec
test_tailcall_count:PASS:tailcall retval 0 nsec
test_tailcall_count:PASS:tailcall count 0 nsec
test_tailcall_count:FAIL:tailcall count unexpected tailcall count: =
actual 32 !=3D expected 33
test_tailcall_count:PASS:tailcall 0 nsec
test_tailcall_count:PASS:tailcall retval 0 nsec
#448/3   tailcalls/tailcall_3:FAIL
#448     tailcalls:FAIL
Summary: 0/31 PASSED, 0 SKIPPED, 1 FAILED

Regards,
Venkat.

> On 16 Feb 2026, at 2:38=E2=80=AFPM, Hari Bathini =
<hbathini@linux.ibm.com> wrote:
>=20
> Test whether tail call count is incorrectly accounted for, when the
> tail call fails due to a missing BPF program.
>=20
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>=20
> - powerpc64 BPF JIT has been incorrectly accounting for tailcall count
>  even when BPF program to tailcall into is missing. A simple change
>  to one of the tailcall selftests could have flagged it earlier.
>=20
>    =
https://lore.kernel.org/all/20260216065639.1750181-2-hbathini@linux.ibm.co=
m/
>=20
> tools/testing/selftests/bpf/progs/tailcall3.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/tailcall3.c =
b/tools/testing/selftests/bpf/progs/tailcall3.c
> index f60bcd7b8d4b..204f19c30a3e 100644
> --- a/tools/testing/selftests/bpf/progs/tailcall3.c
> +++ b/tools/testing/selftests/bpf/progs/tailcall3.c
> @@ -5,7 +5,7 @@
>=20
> struct {
> __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> - __uint(max_entries, 1);
> + __uint(max_entries, 2);
> __uint(key_size, sizeof(__u32));
> __uint(value_size, sizeof(__u32));
> } jmp_table SEC(".maps");
> @@ -23,6 +23,9 @@ int classifier_0(struct __sk_buff *skb)
> SEC("tc")
> int entry(struct __sk_buff *skb)
> {
> + /* prog =3D=3D NULL case */
> + bpf_tail_call_static(skb, &jmp_table, 1);
> +
> bpf_tail_call_static(skb, &jmp_table, 0);
> return 0;
> }
> --=20
> 2.53.0
>=20

