Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A882D0C9C;
	Mon, 16 Feb 2026 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771240334; cv=none; b=hMfwedTceU60BF2JOk0zWsK8NmYUrJos2eEj3U4fJ5qaKmLibFW/VA3nL3v9UiD39quUuqpzRyu1VrcZUOF9aWkE40xCMFjoxLRRNWtEGMbS/qttLZbKRCfHpb7x0Mrv2rHIWienb05Te8eZsCfaIMrWIGwMP+4J5arazIhP8Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771240334; c=relaxed/simple;
	bh=sG0zyeSMi9chg7xm/eKPf7aK4KbLO1eb+m74GSII5tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fS83oRyHYZ0YGlNCeqTz8eTwboKgk4ipGt9uhT85d1tr00DmA/wjFLoFzwJCg1ueErea9iG2V9d0ezFIRiYGcNgNc7NdITC6LyJ0BXAHzwuZLv3bS0kFEtWy3+d0beJRoaBbqtq0hKf5tMW9ya+0tqveXEZsid5TxfIOzwS4xzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aCyXu6c1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aCyXu6c1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FM1J6F3669128;
	Mon, 16 Feb 2026 11:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=j2NPHD
	6edXAJ5Ecp2/ZrT8ESVG/JNWK3blfHLS2Ld5Y=; b=aCyXu6c1NF4Zl9UE7UXebo
	syyg9Q6wvVYJn97VeBtBLbbX6UGoY94Y+LGqoDOCLUzNE+W0+jCHvHplFb7gH0Ex
	oiXxTu+3wZsNhcAYhSUQLJDf5Gyjv8lezaxd26b37K919wT1EDavc3Q0EcFe0NC/
	uaCR3YCoW0+i6byR7OLh6dc4qMaI4RVHGJJvCwB1ECQeBFflRckLqmZNbj0fcU68
	74uqpQQfQ8WA8BHdpqxrGeYqjovJ4jMYrnCtkz+/YX4cjUC8nv66M4HAxa1DlcjS
	t+htSopI0wCrSW6Ofb6k4OSvPoA/z8NbYZM7B5ERXqUphHO4GSP6+1fWmLQn75pg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcj6vkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 11:11:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G6IRsW012624;
	Mon, 16 Feb 2026 11:11:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb3crw7wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 11:11:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GBBqIe28049698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 11:11:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7E4620040;
	Mon, 16 Feb 2026 11:11:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB58E2004B;
	Mon, 16 Feb 2026 11:11:51 +0000 (GMT)
Received: from [9.78.106.17] (unknown [9.78.106.17])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 11:11:51 +0000 (GMT)
Message-ID: <1463952f-ccdc-4496-8041-12fb79ef3e9e@linux.ibm.com>
Date: Mon, 16 Feb 2026 16:41:50 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: test accounting of tail calls when prog is
 NULL
To: Venkat <venkat88@linux.ibm.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, linux-kselftest@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>
References: <20260216090802.1805655-1-hbathini@linux.ibm.com>
 <3A7B8B6A-C91D-4322-907E-22E6268F469E@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <3A7B8B6A-C91D-4322-907E-22E6268F469E@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m_Xjiuan8muSF8zbRpT-uP0ZtmPcaElh
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6992fb7b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=__EkIHEiJ7JET0mok7gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA5NCBTYWx0ZWRfXxo/w2ktvyoP8
 oC/6jCU6E9TZrRqNtdWRLaEUK1XLl0BctsaP5xTDFSwBZI54UsK5gBfHh7h4u70UOU8W1RbQLMp
 dCg6xf1XwEuV0+plGX2xtM7lhccxYwYR6HUAgl9tAkJqXvwp5NXDJIZTSBybpCFFkilOM5EQXgi
 +1LnSRuEG4IWeCLgOXLOnHn4n584Wny47XhbGGxVhdUhJsOl4liM/tudPXvMB75FPiNGlH7udt9
 BwwHEVVpc+2WwCIIH1Nl/FiMlJFdqGT+WP/qzN0kSgSTlM4o90FE+opq89TUl4dyN+fzW6pkvwQ
 D+Jtivs4lL/q8wCgF7E4HRWvN4sGRiBqqGOmZUpTWawJLQhiJNQvMvUpVkPpFvPkyu7NPK+lF4k
 TV8hpyiB0RSEx+9lzYxb3FRQk5YJ9lhZwbvxF2yk94eZ+etAA5SjduN8fNbdPfW5QprkMc+eNEI
 xg36I7jGWUf1fCS2Uag==
X-Proofpoint-GUID: m_Xjiuan8muSF8zbRpT-uP0ZtmPcaElh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160094



On 16/02/26 4:38 pm, Venkat wrote:
> Hello Hari,
> 
> With this patch, tailcalls selftest is failing.
> 
> # ./test_progs -t tailcalls
> tester_init:PASS:tester_log_buf 0 nsec
> process_subtest:PASS:obj_open_mem 0 nsec
> process_subtest:PASS:specs_alloc 0 nsec
> #448/1   tailcalls/tailcall_1:OK
> #448/2   tailcalls/tailcall_2:OK
> test_tailcall_count:PASS:tailcall 0 nsec
> test_tailcall_count:PASS:tailcall retval 0 nsec
> test_tailcall_count:PASS:tailcall count 0 nsec
> test_tailcall_count:FAIL:tailcall count unexpected tailcall count: actual 32 != expected 33
> test_tailcall_count:PASS:tailcall 0 nsec
> test_tailcall_count:PASS:tailcall retval 0 nsec
> #448/3   tailcalls/tailcall_3:FAIL
> #448/4   tailcalls/tailcall_4:OK
> #448/5   tailcalls/tailcall_5:OK
> #448/6   tailcalls/tailcall_6:OK
> #448/7   tailcalls/tailcall_bpf2bpf_1:OK
> #448/8   tailcalls/tailcall_bpf2bpf_2:OK
> #448/9   tailcalls/tailcall_bpf2bpf_3:OK
> #448/10  tailcalls/tailcall_bpf2bpf_4:OK
> #448/11  tailcalls/tailcall_bpf2bpf_5:OK
> #448/12  tailcalls/tailcall_bpf2bpf_6:OK
> #448/13  tailcalls/tailcall_bpf2bpf_fentry:OK
> #448/14  tailcalls/tailcall_bpf2bpf_fexit:OK
> #448/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:OK
> #448/16  tailcalls/tailcall_bpf2bpf_fentry_entry:OK
> #448/17  tailcalls/tailcall_poke:OK
> #448/18  tailcalls/tailcall_bpf2bpf_hierarchy_1:OK
> #448/19  tailcalls/tailcall_bpf2bpf_hierarchy_fentry:OK
> #448/20  tailcalls/tailcall_bpf2bpf_hierarchy_fexit:OK
> #448/21  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_fexit:OK
> #448/22  tailcalls/tailcall_bpf2bpf_hierarchy_fentry_entry:OK
> #448/23  tailcalls/tailcall_bpf2bpf_hierarchy_2:OK
> #448/24  tailcalls/tailcall_bpf2bpf_hierarchy_3:OK
> #448/25  tailcalls/tailcall_freplace:OK
> #448/26  tailcalls/tailcall_bpf2bpf_freplace:OK
> #448/27  tailcalls/tailcall_failure:OK
> #448/28  tailcalls/reject_tail_call_spin_lock:OK
> #448/29  tailcalls/reject_tail_call_rcu_lock:OK
> #448/30  tailcalls/reject_tail_call_preempt_lock:OK
> #448/31  tailcalls/reject_tail_call_ref:OK
> #448/32  tailcalls/tailcall_sleepable:OK
> #448     tailcalls:FAIL
> 
> All error logs:
> tester_init:PASS:tester_log_buf 0 nsec
> process_subtest:PASS:obj_open_mem 0 nsec
> process_subtest:PASS:specs_alloc 0 nsec
> test_tailcall_count:PASS:tailcall 0 nsec
> test_tailcall_count:PASS:tailcall retval 0 nsec
> test_tailcall_count:PASS:tailcall count 0 nsec
> test_tailcall_count:FAIL:tailcall count unexpected tailcall count: actual 32 != expected 33
> test_tailcall_count:PASS:tailcall 0 nsec
> test_tailcall_count:PASS:tailcall retval 0 nsec
> #448/3   tailcalls/tailcall_3:FAIL
> #448     tailcalls:FAIL
> Summary: 0/31 PASSED, 0 SKIPPED, 1 FAILED
> 
> Regards,
> Venkat.
> 
>> On 16 Feb 2026, at 2:38 PM, Hari Bathini <hbathini@linux.ibm.com> wrote:
>>
>> Test whether tail call count is incorrectly accounted for, when the
>> tail call fails due to a missing BPF program.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> ---
>>
>> - powerpc64 BPF JIT has been incorrectly accounting for tailcall count
>>   even when BPF program to tailcall into is missing. A simple change
>>   to one of the tailcall selftests could have flagged it earlier.
>>

>>     https://lore.kernel.org/all/20260216065639.1750181-2-hbathini@linux.ibm.com/

Hi Venkat,

Can you confirm if the above kernel patch was used or not?

- Hari

