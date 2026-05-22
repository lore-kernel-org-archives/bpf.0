Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F024F3C76A1;
	Fri, 22 May 2026 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444752; cv=none; b=IrOB43F6hrkaygmymLqApc7lA9p2hNUCtPAIOYZlsXwdkKD0DIF4Zgttx6wG5cxljcKpb4UWEOsKiaMP6RxcXLvZF1zgfkFzZc0HAd1sbxGLR37j+CFbXyTMG3J3n96ivzLfbb4VrU+/RGpLtxOJaBDlQn0HDzBwmc9Vaq6l0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444752; c=relaxed/simple;
	bh=hY60Sva9v7Hp92Gxc/AqYezUMkI7S7hvDRejUAMAMGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1saIgYWGicZ6ja/YQG4kInFLxMgXAi1psbuwKtHdD3zb1G+jB0/tHIg27SnC8/q04IGLYmGUMUtrh0yN59fWBhaqGkgf4K/Fs+qG3un2G/38EJ5dNiYHveeRQkifXWZ1RKbpVko5qru/WgxMPfqH5h0fiNIQgiYGkHHtCoQN1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qtXuS9dz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qtXuS9dz"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M0FHWN883231;
	Fri, 22 May 2026 10:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hmEteP
	DuOBcL8W9aQtAQSQ76o7WfUAm0iNKY0h37lMs=; b=qtXuS9dznwsHxdwlLvNall
	a2fwqiHwdbI89AyAjG6DXgyuI8jjQSaIR2aeo2IWYTGnTQicf1Dx3f8JBUhh2wf7
	2xdmdqiYbS0Tk8XufL3+1pm74rY5kMIFqfZ8YmwdRvQ/J35epxyEv23YtoQvM5sk
	h4f3bDJd/H9NZAYQmuive8iOQPJtnhSAP/aGqgqOFuRDLO2O5j9ELEdRMfdvkwVa
	3gR130EdMx4GxeZC+gZnQS/B5o0dqdbpoputuAXDQcL20BkYFDB0303NVK6+9k0Z
	lkM7qG927glyMHxsZH6w1qGLfFuf/WIJGLJNGheWC7Di2LHmPHTfrf3Ml9M40RKg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8n3csx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 10:12:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MA959o007130;
	Fri, 22 May 2026 10:12:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dj0bj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 10:12:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MACPDc49938688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 10:12:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C61E220063;
	Fri, 22 May 2026 10:12:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 811082004F;
	Fri, 22 May 2026 10:12:25 +0000 (GMT)
Received: from [9.111.153.207] (unknown [9.111.153.207])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 10:12:25 +0000 (GMT)
Message-ID: <8e6fffba-d1d9-4b77-903c-1c01ee448fd7@linux.ibm.com>
Date: Fri, 22 May 2026 12:12:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 08/20] unwind_user: Stop when reaching an outermost
 frame
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260521142546.3908498-9-jremus@linux.ibm.com>
 <20260521144706.A1EFB1F00A3B@smtp.kernel.org>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260521144706.A1EFB1F00A3B@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bBhV2U-vY_P2nlGcE-H4q-uPJ5htLkI9
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a102c0c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=ZbIifX0CVi-7j6L2khIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bBhV2U-vY_P2nlGcE-H4q-uPJ5htLkI9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEwMCBTYWx0ZWRfX5FMeL5wuvWlK
 CE6fmPqdkUrEAlB6N9taRrRZsVBS4ccn+bteRXzyqkpYM6k/FHhQ+v9krKr1967nJbg1BK1zuKU
 1+5oeT/QoJVAp1I4bfLwl3XEywUgeqQy2EORt3ST3IKn8XWs5LsBHMGhjELcb2StE3IF1yY6og+
 bKTYGr77eQIU/i405x4Fu9RqFNlR/kEBgZ65G/Qtzf47Gw7115ZVXS8mWIQElVlgpp6xG8+gZvl
 LpLr0eLx2Iim+f6W/1iOE/NTK0qYyVpQJDPHIboEhAVZ/dTqyPZlCxr7L/L7yN41UQbW+oFXWdZ
 nanBlYmLzDNSCCjM3ERwzzG2/Iu1zW+p1+pqnGcpF2bG4tvZnDuRzc2EP6sb9NDUc1z/nzfgqZa
 XXgt62lvg99Tm6Oq8LXdmSI9g4Mib6LUMBJQG+q7ZtEfEvRSbUWq+ebO/zknojPl1d8h8Y6HsMi
 +MrtfPjKE2rUWl/zpwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220100

On 5/21/2026 4:47 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added `outermost` field in `struct unwind_user_frame` is left uninitialized in `unwind_user_next_sframe()`, causing `unwind_user_next_common()` to read stack garbage and potentially terminate unwinding prematurely.

Ignore: This is no longer an issue after subsequent "[PATCH v16 09/20]
unwind_user/sframe: Add support for outermost frame indication".

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

