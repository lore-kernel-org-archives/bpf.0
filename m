Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739A22405EB;
	Tue, 19 May 2026 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201061; cv=none; b=BL2tV/iHqEDqjEql3MsszdXxxryXcne85ipTVrAb11PSQ5SGSsHI+Q2DxYtntfPSWOV0I3iPIApbPOlz+Xw5Wy71GTgAsSbrq/CAPiwbRrZ5tOWUK+tLwAw1l23B3q4S8gJ5DG72KeRm3rKvJJ5GMkaO9ouvcMTUqtwnBlUyZpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201061; c=relaxed/simple;
	bh=wrdkZ7DRg/Uf6EOtaf+aEPytCIbrMzp9nlsNTx9V0jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8LVXtDmwOKTBwdSC0NtbDjyZVj80GRxAzlpLsU6U/bLlmdTfdzbRzQVbuCLhC07YG8G8QSZRyohc1AuBDuNhXRHCxizWbjoupQ32gCZkciYkhz01T22OmDZL68uWHxBUrg3bcBB93nBdeJhMK2MPbhA6rGohvfBhg+KS2dK5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GNW1eE9e; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GNW1eE9e"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JATvcI3469512;
	Tue, 19 May 2026 14:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PBV99f
	HpK0TwvNRo0gV03N+uyfhHuWlOZxMNV+iVr30=; b=GNW1eE9e9HoQaNYvNP+q+V
	xzTrsYXM+hLqwU65mkFeaKm+Xm/OuGuWZjbBNpaCgJtMDbR+1B8zCBJzXRCXSwt3
	L3iianewPFpQ0XF/UXm8DAmAiddxWE58cCwuIFwF52S3APadNgaUTtWyBjgldtPj
	MJaLe5UPI2P+4QouznBNn9QbGd9IAZsDgZMLBux74yJD2BYBJWcc67yVuySaH5A2
	GAUVdZqYJ0tWHtD3SloCvZmBejbWqKgrpF+BAepXeH6SamwGyvTVpukSHyMYfPPm
	05fZPLvRUntYVRIZ4Dqu//XLGYbqBbV5MsV5r68lL4T5Vk99hoWhqpFImML7oy1g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mnern-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 14:30:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JEO50N014220;
	Tue, 19 May 2026 14:30:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vu5h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 14:30:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JEUsuj43254140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 14:30:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B2AF2004B;
	Tue, 19 May 2026 14:30:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5AFD20043;
	Tue, 19 May 2026 14:30:53 +0000 (GMT)
Received: from [9.52.200.195] (unknown [9.52.200.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 14:30:53 +0000 (GMT)
Message-ID: <ab7c154e-aa60-471d-ba03-334e55d1c74a@linux.ibm.com>
Date: Tue, 19 May 2026 16:30:53 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 13/19] unwind_user: Enable archs that pass RA in a
 register
To: Steven Rostedt <rostedt@kernel.org>
Cc: bpf@vger.kernel.org, sashiko@lists.linux.dev,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Indu Bhagat <ibhagatgnu@gmail.com>,
        Dylan Hatch <dylanbhatch@google.com>
References: <20260505121718.3572346-14-jremus@linux.ibm.com>
 <20260505183531.C9EE8C2BCC7@smtp.kernel.org>
 <8761b037-d8f8-4142-9091-cc51d0d19df8@linux.ibm.com>
 <bd711f74-a1f3-4410-975b-64e9009aaf30@linux.ibm.com>
 <20260518123112.20da820b@gandalf.local.home>
 <4838400f-209f-4e78-b41f-04b61d129ee7@linux.ibm.com>
 <20260519084222.4d34c8b4@gandalf.local.home>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260519084222.4d34c8b4@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 57zz_oqI7farCzu2Wfa-yfpEUqCY-_UP
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0c7421 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=kWH43m-WBJ70W3cScMkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3ryT4dwjbiKCT1onmBO9yaFlJFP9omZF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0MCBTYWx0ZWRfX4L87o4C5L4Fg
 fMlvHnTBX4DK/s/I1v+1fEI7lqTY8Ga2vtbswZgQa3PIajwgok1WuDeIcqomtMik0Lk2poYFUF8
 nA3K7sFLflAzsRbt+KlEJ0ibjtSUzlp8QPbSsq0iMhAJrziKN92RHxqZSVWvC+EaZ24a9OSJIxJ
 +lirp/zJo1wMeEMFVI8zsKbw4tXvgNk1eeP1wSJdxsw6tPU4VC95+Hs478d48AQTR7jWhYbCDxb
 fQGYaNCvXUokglt2A2egU5UXagJYE7rgmu3EturWKScLrSkVm55YLVN+cErTfPDg8KE2kFbGswB
 hT4perhd7EDzsIa5n0qh8sFVE6yChtI9rEzI8O1Z+vEZH0YajF3eBad5bOVJ2fiFx/1Mrk5tlUI
 28IZgFGWzTbMsfbCeY/qZPaGybH//rC66MNaMWhLahr6PLLzclxguSBQd6IML5VxPTaeaPyIk4K
 0kzFW9mTUHqfDOUlGiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190140

On 5/19/2026 2:42 PM, Steven Rostedt wrote:
> On Tue, 19 May 2026 14:24:34 +0200
> Jens Remus <jremus@linux.ibm.com> wrote:
> 
>>> How can this be triggered? Does it require an architecture to implement
>>> only partial sframe to trigger?  
>>
>> On x86-64 it can be triggered from user space using forged .sframe that
>> incorrectly specifies no fixed RA offset and thus causes the common
>> unwind user (sframe) logic to recover RA from the RA register using 
>> the dummy unwind_user_get_ra_reg().
> 
> OK, so if user space could trigger it via a invalid .sframe, I would do at
> most a pr_debug() (may not even need a 'once'), and remove that this task
> has an sframe. That is, as soon as a sframe is discovered to be corrupted,
> it should be discarded and never used after that.


Removing the .sframe section is not straightforward in this specific
case, as the issue is not detected in the sframe decoding but only later
in unwind_user_next_common() once it calls the dummy
unwind_user_get_ra_reg().  unwind_user_next_common() gets called by
unwind_user_next_sframe() after it obtained the information to unwind
the frame using sframe_find().  Therefore the offending struct
sframe_section is no longer known.  A reference to it cannot be stored
in struct unwind_user_frame, as that would require a SRCU read lock to
be held.  Instead the sec->sframe_start could be stored in struct
unwind_user_frame, which could then be passed to sframe_remove_section().
Instead of adding sframe-specific information to struct unwind_user_frame
I would prefer to use the state->ip as key to remove the offending
.sframe section.  Below is a compile-tested patch that outlines how
that could potentially work.  The sframe decoding cannot detect this
as it would need a mean to know whether the architecture implements
unwind_user_get_ra_reg() (and likewise for unwind_user_get_reg()).

Is there a simpler solution?


diff --git a/include/linux/sframe.h b/include/linux/sframe.h
@@ -33,6 +33,7 @@ extern void sframe_free_mm(struct mm_struct *mm);
 extern int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
                              unsigned long text_start, unsigned long text_end);
 extern int sframe_remove_section(unsigned long sframe_addr);
+extern int sframe_remove_section_for_ip(unsigned long ip);
 extern int sframe_find(unsigned long ip, struct unwind_user_frame *frame);

 static inline bool current_has_sframe(void)
@@ -52,6 +53,7 @@ static inline int sframe_add_section(unsigned long sframe_start, unsigned long s
        return -ENOSYS;
 }
 static inline int sframe_remove_section(unsigned long sframe_addr) { return -ENOSYS; }
+extern int sframe_remove_section_for_ip(unsigned long ip) { return -ENOSYS; }
 static inline int sframe_find(unsigned long ip, struct unwind_user_frame *frame) { return -ENOSYS; }
 static inline bool current_has_sframe(void) { return false; }

diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
@@ -21,7 +21,7 @@ static inline int unwind_user_get_ra_reg(unsigned long *val)
 {
        pr_debug_once("%s (%d): unwind_user_get_ra_reg() not implemented\n",
                      current->comm, current->pid);
-       return -EINVAL;
+       return -EFAULT;
 }
 #define unwind_user_get_ra_reg unwind_user_get_ra_reg
 #endif
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
@@ -886,6 +886,20 @@ int sframe_remove_section(unsigned long sframe_start)
        return 0;
 }

+int sframe_remove_section_for_ip(unsigned long ip)
+{
+       struct mm_struct *mm = current->mm;
+       struct sframe_section *sec;
+
+       guard(srcu)(&sframe_srcu);
+
+       sec = mtree_load(&mm->sframe_mt, ip);
+       if (!sec)
+               return -EINVAL;
+
+       return sframe_remove_section(sec->sframe_start);
+}
+
 void sframe_free_mm(struct mm_struct *mm)
 {
        struct sframe_section *sec;
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
@@ -45,6 +45,7 @@ static int unwind_user_next_common(struct unwind_user_state *state,
                                   const struct unwind_user_frame *frame)
 {
        unsigned long cfa, sp, fp, ra;
+       int ret;

        /* Stop unwinding when reaching an outermost frame. */
        if (frame->outermost) {
@@ -94,8 +95,11 @@ static int unwind_user_next_common(struct unwind_user_state *state,
        /* Get the Return Address (RA) */
        switch (frame->ra.rule) {
        case UNWIND_USER_RULE_RETAIN:
-               if (!state->topmost || unwind_user_get_ra_reg(&ra))
+               if (!state->topmost)
                        return -EINVAL;
+               ret = unwind_user_get_ra_reg(&ra);
+               if (ret)
+                       return ret;
                break;
        case UNWIND_USER_RULE_CFA_OFFSET:
                /*
@@ -173,11 +177,16 @@ static int unwind_user_next_fp(struct unwind_user_state *state)
 static int unwind_user_next_sframe(struct unwind_user_state *state)
 {
        struct unwind_user_frame frame;
+       unsigned long ip = state->ip;
+       int ret;

        /* sframe expects the frame to be local storage */
-       if (sframe_find(state->ip, &frame))
+       if (sframe_find(ip, &frame))
                return -ENOENT;
-       return unwind_user_next_common(state, &frame);
+       ret = unwind_user_next_common(state, &frame);
+       if (ret == -EFAULT)
+               sframe_remove_section_for_ip(ip);
+       return ret;
 }

 static int unwind_user_next(struct unwind_user_state *state)


> 
> A print could be done just to inform the admin of what happened. And since
> the sframe would be removed, that prevents it from spamming the console, so
> the "once" isn't needed. We may want to show it for other applications.
> 
> The print should state the comm and pid of the task that failed.
Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

