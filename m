Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA5D5349BE
	for <bpf@vger.kernel.org>; Thu,  1 Oct 2026 21:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889776; cv=fail; b=l98H3RVWOK6OifZX4jhJlO7wrjQV2onc0OxRs7P0CjPbVBEuUF21NzyERKp0tFoCZVZJfi490/gtgS3Tk6JdqBFlJUjpQDqZSvx9XPSmRbYnJAtj4USds9hIxIC7/woFSh53knlkcOnNfdj1P4GOrrPPwug9TLymTlSAD4A+ap8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889776; c=relaxed/simple;
	bh=42KMNjndOztbmwwDoexhu0dMtE/8+6vzzt5bNYkI5J4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YPNYbdnb+SqqPaBKG1Lbaab4uo8X3XgRC5+oZW4RxaS5TX5TNXrCpNmGQB7eRkfABec4E1wTpzRW01g6mbJaF1D2fRfJBXJzcuu8KHhLw+h4XYRyVqG3q/fITWoLb7TXDOrSN8H/mOpkl/FJAmyUfunuYv5jJsytaLjIXjzEvX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=olLdJtUC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q9C/+FFz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="olLdJtUC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q9C/+FFz"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 691KRxYm908031;
	Thu, 1 Oct 2026 21:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5ePJkSX78EZxMJAN7kHReg7QCx9ca99IBXqUk7IAM+A=; b=
	olLdJtUCt8glBXyHkq6Cf2gRELnh29YpXzsI2kREd5h9voRbl6AazoSZlh0ULwNM
	FED9878QJv3EskvHy1no035Tke8T4oFSiaM3ZeABiEr1Sog4o1z9g+MKIyhPAP++
	TuOcqVFN+uwlPDg7sDz8qTIHOjinO2MfFAbHK0qIasgPV/gB2fJxKOKa3f1AFiBX
	9IDfYqf1niK5wtMqJkh9wQvbdBpFnLuhqYeCmzLA06z57nTFe8nLNqN5OwSNy8xn
	CsWFSu1Ggp0Ws5qDihOgDvl2T8RIYU6kiMIWLdVoJIBOIXTtL0abgJstkLWx2Clm
	v9djphhNQigihAZQVDAHuQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gx4u2j90q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Oct 2026 21:22:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 691LK5no027133;
	Thu, 1 Oct 2026 21:22:32 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gx4gec9tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 01 Oct 2026 21:22:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFnME89BBoh0rTJklOMGJUc0aJxvSJjl4dFFKxfECKyDAaJhfLjgeh3KTRlVgUYL7V0xCYwn1HQod/etJ2zdsQv+B9UWjlQtsLNMz81C/ZtSnnGX4pbEBZLkJMwASdvK51CbgfuC4Yx4WKVGKoXaVjJMgi13f0mT3hELtwZ+agWE9JlAWzym7lhD09Z0mtsESEHdgSxKxiOmrrY/n5GG7UaMFFtxdM78ZaT580OEl1TXLk5xMc7t4Ki1RRSudhBBfEr+7gZZ+Za6UD12vh1Us9LyltddbHfma6h4YQKBUuHr0iNWPFGrsfYbfR+AoQ7DZpu1SXhr51EyTu6hoLQ98w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ePJkSX78EZxMJAN7kHReg7QCx9ca99IBXqUk7IAM+A=;
 b=T1B1mUkDm1WbkqezPwA0tYxYfx2AggnA7MIIstINPu/gnHPOoVJmdxmkfb/MDBCnK3BQh1yoLg9alwPKsSHcR00BuWU/Vh3xQG+bF7NP5jepHCpWa9j+ohJCDGTjqD1wv/ivCGwwOh8Iq/Hi/iGXIxE1OBXyrz2MtrohVGxcG4ShLEcKplbVTXw5McKCYrqPeZUURrrcRjpQBcq4lTArTYMrHKFcGFc2bM2gO3Hg+m+JjAQiINdVnJIeAkcoZ2C43gqzDweVNyy7tw8HchI3SEeGzwsyIrlmtqu/ZXZxZFz8ONU9sH3peWAgdH6zn11dQSs/SboVmFRIU3PlUHgrFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ePJkSX78EZxMJAN7kHReg7QCx9ca99IBXqUk7IAM+A=;
 b=q9C/+FFze9FZ8Os246DjKWGcKsPFWvTJHU0kMWzJz20inlXkhlIzj0YtmmqxHyLLQyMLS5VQIkWbX3Qpqjh65rA8kPGmhjN1p9E192QKULZO8wwvJUbH6CwGL1KDXCZNHS0gDbyDuXBEEDKPqLpOUavjHDVdNW3v9lbghcYB8vA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CYYPR10MB7567.namprd10.prod.outlook.com (2603:10b6:930:be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.9; Thu, 1 Oct 2026
 21:22:28 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0496.008; Thu, 1 Oct 2026
 21:22:28 +0000
Message-ID: <3ce2819b-183d-4890-971c-121b5a0f52da@oracle.com>
Date: Thu, 1 Oct 2026 22:22:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 08/14] selftests/bpf: Add test for arguments
 without names in static functions
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
 <20260930193127.2181684-9-alexei.starovoitov@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260930193127.2181684-9-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::13) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CYYPR10MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 15014ee8-2c1b-4784-be27-08df2002188a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|6133799003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	H/JPVUTlWgLUPjK6n6aPJSWdaeavms97O4ixc6Tz0WqytWR/rJehWOEYCfATQufpRdIRMY90C+0fzeCtMgfONsyTKSdfZkeHKSeVH8tX2Q70N3iccmvW4PQgCbsrDanpocPaj0RYyEqX3LoejRmdnqUyfEADqGU/nknxIAIuuRAELAwwj2woVE4lLaOTdQPAzeXzSUFWRUGX7xUk5pgO0xAjgF9zeL9QPUUZApL3HMOpnmrIdVx0vGkBHRr8TgKa4xZjLsWHYDvZDMeXqd3WHdqxSeEjIQhhk6GLs8yz+fNUxilsPWEbtv4Cv2Mu/lwmI/K0e3ve+r//Dq+vigL3vH1qu7h8GxfAoMKTL9FNg5thVdmrmKPKzNL8lGgeyjnZ5vwyvGdSKkC6EcFZFlfJzJr8n1or7l2TknHSqE5QQZQxFN9SMxgVzguhOQOJWA/D9J/bFCtouMgw3kZ2MQSW9nAC4OWI99eWUEr1gqgJK3LN6X0sKeHoqbXh4SzCzbNsYR94EpZ/Sn2f0ynFFBubH+r4bO8RJQoKG3T3/EXMNhXitzTL+4tFdlUBkqJXTLFlr3s4rmtUzRWe/l0bYfrBdkW6FsvsjKca0uswGNjCSzpGtFhzAXLyfs8Yuvpy5ZlVLDAbBLcOIl9ENmLAMriMwahBQeyIkhmXK+8w2q3RAqE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDFIZkdyRGowaDdoZThNTmwwa1l0RnlBWHQ5MTIwTm4rWEQvZzVzdGtiSnJN?=
 =?utf-8?B?S2R6d0JCc0JlRm1xcXJrYmdwdG4yQVliU09JdVhiZUt1dnV1Tzl1cXBXMXpH?=
 =?utf-8?B?SmRPOEpTd3lwVGU0cVhsei9BZnpVZmUyaC9qSmc4bmRGbllDN1RFbWtZKy9T?=
 =?utf-8?B?ZUFhaFA1Q3Nsay90YlppaUhlVy82TjNqcElDUTczSHlURlFLTTVMODFqd2Zt?=
 =?utf-8?B?c0NCZDlPeDBlVzI5NVVFUnAwUTFCQXBrWk1seVdzdlJEV05JQVJVa1NTc1Fu?=
 =?utf-8?B?dXp2eXBXWW1tbVJyUnpLVDRZK3BRR0FTaXkzMmZFTVNMTHNOckFIMFI4RUNu?=
 =?utf-8?B?NkdwQlN1YUxOMnhkbTN5YVh0NW5kZ1hOMzgvNmZ5Zm1yb3YyTDFRL25qaklZ?=
 =?utf-8?B?NHh6TWVmdXBodEZPQTduWE9EWVJTRGJJWnBYZkJ3OWZSWFJtcjc1bGxjRkU4?=
 =?utf-8?B?a2hiR2Jzb3BhdDY4dTBrby9YKzRyMDFkS2k2ZEZXVHg3UkIyZGt2NDVwMHVi?=
 =?utf-8?B?SXQxMTA4UEZvVVFiZFFJSTl4OGJhNnI2Rk9DVlR6S0dOOXdxaWRVM3plaHJB?=
 =?utf-8?B?UkZzK1Fxcno5MWlXdUNoM1l2Tk9mUUNkRHN5L09NK0RhcjdNc0FLWVhHbkUw?=
 =?utf-8?B?WkV4dmdub0ZzRVh0NUE1TStFUGZNbk5TVk83RWZwN0tWWERLSTlwYXFGeEdv?=
 =?utf-8?B?Qmhib1hyQnVaMXFWTGZwL3FxQWl1VExtYUVUL2FmYkFJWFcvTzh6V0VpN1Bw?=
 =?utf-8?B?SFBhTGk5bGduSWtOYk5QdnB5MEg3aG83bzUraWFpaFNhYUlrVFpEWlFlMFdW?=
 =?utf-8?B?Y3JlUHBkcmU4aG9POGNjbEJOeEJISnduZFFodnIwU3EwdWtydmVOMG0yNXVz?=
 =?utf-8?B?VVVwNUROWVZEU0s0OXgxT3dlTFJxT0NKZVRYZWZlYnA1aTFjaGtsdTFqTExv?=
 =?utf-8?B?dmJFWjlzcFRzSDhGZjJLTXF1NkM1djd3NFZ1S0locVhOS21yTUlydmVZWG9I?=
 =?utf-8?B?MWRvSU52VmIvSldTaFMwYWhNU1oxZDdDMmM2YWFJVm1MQWVQNVFXQ05SZmJX?=
 =?utf-8?B?RWh5VzliU2s5dFlvSURYQkJhOVZzV0xPUDY0bmU4WmpUK2dSdXFjVWFjZ2lX?=
 =?utf-8?B?QytPWWROYU0rZmhYaldGNlFhODQ3TERBdVQzZjBvM1JjYjNhZW5mM2RLbEJI?=
 =?utf-8?B?YjBqQ3N1WnZRYzBweFV4eGdWRFlTb3RQblRRVDZ0TzFaYUhDOEZYNStzczdW?=
 =?utf-8?B?T1ZmRndxekFNVDhvaWFNTTRwYUhFaDJaS2twcWNoRUV3SFpKb0R3UTN0NVpS?=
 =?utf-8?B?UXNxWVRwR1NmZkxQS3dBemMxUHgwRy9PQUZMOCtFaFY4MFN3ZHZmQStGSlZE?=
 =?utf-8?B?T2lBNlNQemI2enlNRXJ2V1ZoZ3M0OGtnQjljbFQzcUo1VDJiNE1xVmZncGlQ?=
 =?utf-8?B?QXBYeEtLK1ZnNjJha0lwdnpRZDFQcHNSMXJWc0hnaS9SZ2RiSzZnb0dSeFNT?=
 =?utf-8?B?ODh4WVFGcHdJbnBhQUxyMGFxMnpEaUQ4dTY1aktlN2xpTG92bGlEQk43bm1y?=
 =?utf-8?B?cHBhOGRlSjJmVGRIM3dnLyt5OFdmQUF5YXJXa2F3SjdpZ052YkRJSVRlTzZG?=
 =?utf-8?B?UDZmcXR6Rm5DQ3d1TDdhVnpUN3VCRDkrdkdYR0pMcGFiM0RJdWVYZFIrSEUw?=
 =?utf-8?B?d3VsTFlJRUxHVFdhVFJBWVNMZmtybWFvWWdHL3M2dzE0RVBTV3IxemFUNmx5?=
 =?utf-8?B?RGRyR0Jrd0JmMVlocVhoYjgwLzExZmxvUlNYYUU4Nnp1UHZWem1SWWZMS2xn?=
 =?utf-8?B?STZ3cSs5N1ZvbHlzUFc2V3JJN2hlVzhNZjFmSk5JQVZ6U0VkcUpoVnU4L1ho?=
 =?utf-8?B?bkhzQUJlYnMzUzNMK2dIWGp0QXFOend3b0R5SjcyZFBrMnRCTmxjRkFzNUhP?=
 =?utf-8?B?OHZYOU9JRlZEOXJITUh5NHdtNERjWUpaclB3dGs2QUx5T3VCSnJVNUhVanJI?=
 =?utf-8?B?aEh2SDJGRERjYktPWlJNazJ5V09YRE5PUWZuRkRBeGdsK0U5NlAzcjNIRjdJ?=
 =?utf-8?B?eWl1VG1sTHVnTThiTm53ZXQ4Nmc2L09sZVJXOWpBbzM4K1ZuT3hoODNEemg5?=
 =?utf-8?B?RGg1VHZlYU1vWGFkMG5iYnQ3MWFjSzQ4ZzZ2MjVjS2FNQ2Q2RDNEcnUzREVJ?=
 =?utf-8?B?YUs0NHplL0t6QUp3bC9odmlRZjFVZnd3OUdjdnlYVjhMb1RwTGdpekpOSHBi?=
 =?utf-8?B?UExVY09DclMrMEdacjBveFFMNzhkSWU0ZlRDVmNURStyN1NLdGNvMUxUY2hC?=
 =?utf-8?B?cG1XTFl4U2FjMnNOK0h2Yy9Ed2oxMmg3dDRwS25BZEtpVWVqVWlLQT09?=
X-Exchange-RoutingPolicyChecked:
	VujIeBDfJhbfcWDCGKxZsI6VEi9xKtsgB0xk+Yw/piuaF0jwsEtdJGeeM7dOOzjreB/lSlBwScI6icWvr7RdFrsUvObupPjIAU01Pxnv5NZ6vTq4b3BzqaoGyOPiaDRTyBdnv6MC+w6Qi/pahKl8NxjSHA1H1y0agxIzMzh81mNI9Q4FGzVBCIyHrcgHdBNyRj9Jj+60wyPhn5fDqF46f+kT1C2k+1G5j8hPV6H7g9E3GQqP/7zsSkXx5TGj59lbSac0JB/sVb5Zq/rWTPjn+upHK0wjOUAly81Ae1iUhmRXrfGedwDl4wfxuo0aCDcvk549xZFSpQz+i8A0vKzUyw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ON52WVUf+00lzGPtUOp/CpDGQhj27l0fqIs5HxEg4TgutHTbuTOvbW0FhAtJZgML2NvHNOgeg2/5KrrDEkoeIPJC1TDakydjqhdKUHtdQy5HAozkA7WTx7PU0Y3lIZH2Zxdl4MwPQHjXRONsHR35dmkQa/8u76WdYMo/p+aWFYy9jfztf1Z0QG8SwhQ4MhLtq/4Ncr40yc+ZN/RyYBoFAUTCmiVNq5hyGAmFIev/s7S3WNVRqT0hFiwTWB/MzZsiE8M3XmSYITSHZXazDR8QCinvEj+dlbp/tXbC3gSQox8Oqxazx1mj7u8y+zSKD2PG/J/ejLOlASmhzhP6EbOXVQ3ps9dwL0am3EFuDsD0Mjbg1gBhhu2PdxpL4tn/31TrQslFfhfe9+e6kBHxq+p5lKX65DP6VanL6zKnaSkdbUK/np2KjnZ2NVATg/Qf+hUAwEvRoHOi27K4SpvGBGRl5ztQ7c5yaEZRaaqpCInlTUBEd25+S4Rwnv2ce7Lja4cqZ2k0YeAuHtr0G89SZrYyEn+/8B1wmooWv0DDTRhKZYDuEaHYtu5kh9B9nACwrUETMxm5ZMDr9bi7AXq/Ufcsk0o2Ed7xaWsNiLIkq55l3tc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15014ee8-2c1b-4784-be27-08df2002188a
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 21:22:28.5171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GRS406ybFCu3l1HbPf3pOsrXrjlVIMD4mym0fs3TdIC7zLhIMzGbuCCOLBGXxzLQGfuJ3U70Kku5N94T9ukI/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2610010085
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4NSBTYWx0ZWRfX3EiiBIUzthCl
 8OuqasA9j7tDWfHZNNIeOD++yktjbzj1uXK8wrIh1fpYurZKSIH76iiVeoTE54OrQhGB1coeMas
 txwcD+dD5NsyPclduP6gTTqwhCLPgxgcPjdFDHVGzTTxeFYojdc/
X-Authority-Analysis: v=2.4 cv=W9itxhWk c=1 sm=1 tr=0 ts=6abecf19 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=EF3nloG_pG0KPm-6790A:9 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-GUID: qLlEsskaYxguxXxucTkKVKCAUpEtlGQx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4NSBTYWx0ZWRfX6Saq5L7mIzQZ
 ffrTgkcZyxQqW9PRrODkjS+ISY9/H8GhA9NqhWxtX6kxwkxLxM9OZ50VfaxJmNsX7WtNGAg5dzo
 krqZG6UE0fbx5O+Ms87iEAw1J0bJeEdxeDv8OqHG7665sHiQSAfEAI6xCcgkeInf5VgBckX6uZJ
 +AD1E/17VSsp3S++I1IsjqYmGjE08Uf7nP4feOtjw4kvCYmblQ94rp7+p81/jo673Nak7CKXT6I
 UwKxhucQ3ZO+Tos2zsboDr6XQ5GQnRFFYv6grAZUZ9XrUs1b2kaMihspC5acrf43+QnSkfpW5Ax
 17vj6UQz7HrY7/7MPEKwGDSlkDgW6rohkEGgWGclBmLfyo8WolALjgsxyeeC0gzJHKO/5/KqFFQ
 ck2UMYdPyFC+5LQARVxYj4bHgm3E94EqP0QiUrt3mZDEF0niQAImkpQ6xOHazLm/dVEPOYkAvQn
 IVPq87I2nrKoLCVG01w==
X-Proofpoint-ORIG-GUID: qLlEsskaYxguxXxucTkKVKCAUpEtlGQx

On 30/09/2026 20:31, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Check that BTF with a static function that has an argument without a name
> is loaded.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Nit: a few extra comments for readability would be no harm (see below), and
it might be useful to add a global function with a vararg parameter (signalled
by a proto parameter with type id 0), since that allows an empty name too.


Acked-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/testing/selftests/bpf/prog_tests/btf.c | 24 ++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
> index 21fdeeb23405..751cb14c1949 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -2819,6 +2819,30 @@ static struct btf_raw_test raw_tests[] = {
>  	.err_str = "Invalid arg#2",
>  },
>  
> +{
> +	.descr = "func (Some arg of static func has no name)",
> +	.raw_types = {

		/* int */
> +		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
		/* unsigned int */
> +		BTF_TYPE_INT_ENC(0, 0, 0, 32, 4),		/* [2] */
> +		/* void (*)(int a, unsigned int) */
> +		BTF_FUNC_PROTO_ENC(0, 2),			/* [3] */
> +			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
> +			BTF_FUNC_PROTO_ARG_ENC(0, 2),
> +		/* static void func(int a, unsigned int) */
> +		BTF_FUNC_ENC(NAME_TBD, 3),			/* [4] */
> +		BTF_END_RAW,
> +	},
> +	.str_sec = "\0a\0func",
> +	.str_sec_size = sizeof("\0a\0func"),
> +	.map_type = BPF_MAP_TYPE_ARRAY,
> +	.map_name = "func_type_check_btf",
> +	.key_size = sizeof(int),
> +	.value_size = sizeof(int),
> +	.key_type_id = 1,
> +	.value_type_id = 1,
> +	.max_entries = 4,
> +},
> +
>  {
>  	.descr = "func (Non zero vlen)",
>  	.raw_types = {

