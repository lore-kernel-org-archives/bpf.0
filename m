Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2E316F83B
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360335; cv=fail; b=a0MgSUbHzWnUKbS6BxmRV01/TOT+0hoRxvZekUznVVSR+ldaecLkgA7ZXv1uWKuMfIcrv5zCx/9zf54ZTIYrB7hAgC4XK3gC/lQ0+L0uKnE0m/zTzNIQdkzFxhVtuUAWMqlFcs+8vK7j6tGanUoz8HalL4OCOOo18Ej6XordxdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360335; c=relaxed/simple;
	bh=LAofXVcGGBWbJCYpSCH8LvUlQWnwfczxy30J8eOhXzs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=joEPDVLiYZ3eL8b+l1Yfanah0+Quo4oMiAff8KgYNUezjM6RbQWOZFlq+1p2ANpy8R9cMww+RqyZ/as9A5mh7AI9/AUsv7An3BwGF5QEld0z9qnCYDh9IzfJJ11Tu3wFQzOvzNhFUaLAho0c+trccRPZKDC+cz+vgViavzjFsN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JVpKKQSn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m8Og26Pg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JVpKKQSn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m8Og26Pg"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42P8pNRb020190;
	Mon, 25 Mar 2024 09:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=UTX5L8+ueAx/Rv6ywnyfbDfjweJCApfd1FvGI0qHPJg=;
 b=JVpKKQSnFlAlTqVnP2fx0WyvFtUBnEknnMAWCinc63CTPoNWTxAtyxNvL684zVbpJ+kF
 g57M+Jz9Mi8KLLGex8ncOBI8NclRDChnyGv/z3Fd4zkfwoV48N4DoIu30eqEilyvpb4s
 9kiqVhOZjSwyBDTmwXh1hZ/rYANdcH5R7YG9930AXZEQakEVymkeDKhAPsraB/uyA/x8
 dxzaNvxKn0k7/AnnuoIjZTxio3szYkqSJNATMvU0ZLcyykOlM33LEC9P6MiqccpC15VE
 0rT4wVJJpgDmUS35ExhELlSmwM23pNdo1kEDD4wsmRZ1RcwwtRk5AzkMBXS5QXLNZASW cw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1np2abb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 09:51:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42P8FSn1039753;
	Mon, 25 Mar 2024 09:51:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh5cad9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 09:51:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DumnhG9L102repCKpUIcvt2W+NI99XqR2noJO8Fgvf30ACz2eAnfrvMDqXmXBDiCv0cWJDVptXyKJdQHxVw95x+25qTxUcewU+CPXeFjzVI4u24eAaCfyWTTKx4fUinh8GHduBMte9F/4xYgVwWd0XUZZakJ1vBtADrU+XQreJlpDkNbaQXxm8Ooa6FRI8fsXw30VJfGndvrEOlbS27idWZw8Ch12oysXBIwVtjN9Rl8xtqLMvoOh9JJEt7+gosxwQ8LJl66YxSXFDM1CmLq3s6+94ZgX0yLkrh8mqfBJHxfuKJV+Otu6hgDWggjYv3stdiPbMYscu/BFOyLlQokTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTX5L8+ueAx/Rv6ywnyfbDfjweJCApfd1FvGI0qHPJg=;
 b=Jr4cpsVEZyik3O8QSmkQO4FCx5LlCG7ZXzp9hV3fkD8+1PWhDLbsHP/cqsZpTR66iI+jexajA3Uj9roALkpDUMTCtD/2sMOvSh13q4yKhL9UFIcQsH1nFrdIgiolRmUZI0yzZX3Zn9wFv3tIIuPNfZJ+n80daFU9aPpLB8FOHt/RlPf1w95NYNANbbN9v6bH4UdwvhNhRIvlKXs6R7FyL2H+Ti4pQ1kMqm8Sc5QgEMn/3SKfVg3G3UMAt+INEbc+7LA1szkLaBWPWs2an8Gw3kzt+5o6pBM8w7muVKkOuF78Ofocpf9KltvUKo3VxwsX7snEtNjUsNsAX+idPOkJ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTX5L8+ueAx/Rv6ywnyfbDfjweJCApfd1FvGI0qHPJg=;
 b=m8Og26PgunlUjsWLVKj9UwPMeDfxLrgUrCEqQpQEb7xfB+k+QMY9cYXCWMEoB3fN4wqr0+scmIyN9N8uYf01E8umeo2isf71OCXN9iXTiwsQ4vDe9ZLyCp2zH1PBtb8bGfRLMFNHh0MNlC+V5JREORIkBui5c5KSVfkvGvlCUKo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB6053.namprd10.prod.outlook.com (2603:10b6:8:ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 09:51:39 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 09:51:39 +0000
Message-ID: <96c014da-9ee5-4c54-99ab-bc0ad87f5390@oracle.com>
Date: Mon, 25 Mar 2024 09:51:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 08/13] kbuild, bpf: add module-specific
 pahole/resolve_btfids flags for base reference BTF
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>, Eddy Z <eddyz87@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Hou Tao <houtao1@huawei.com>,
        bpf <bpf@vger.kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
        "Luis R. Rodriguez"
 <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
References: <20240322102455.98558-1-alan.maguire@oracle.com>
 <20240322102455.98558-10-alan.maguire@oracle.com>
 <CAADnVQL+8cm10fg69nqnDKQaSfoFK7NPwa16CB7PQJAdCHsBKQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQL+8cm10fg69nqnDKQaSfoFK7NPwa16CB7PQJAdCHsBKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0583.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB6053:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a3ba21-1b6e-4cc3-3ef2-08dc4cb12b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3npFbYc4mw+AKas3RNHrXFqg8z8c+MzXkxU+GpIO9I3f9O3cdDSzDr95uD/S/lnfUZE6bVzEXVUtt7JyRTSe3LehpjxLSNCm1FMcqfsY9GZREr+ibQnDglcDlN7S7PEo8m47gPQosjaj3KN06kYDOs8idGog5Pnrrssj7Incq6FADZvm8wYevPfMVXNyiakVGpyzdXo6PurlQ5Fwy3QXJpumcKsMHORV9A5D0ttZmiyJnNYw+RQCEyEfGo7fZnyAz4rKECiXjoGy5bqB1CVe//NY6Ud4BiNZ9jg8r26WOVMzu1e4S/3utQW6h7uYfjaxzKfY4Yw8bQywFruc00uYHZe6PUfnfGkj8517KViazqUABP0o1Ky05THUsjzuDpQ+Njf9yakcRQ7ylMiBY1IIVMZt6CciMiiy1TNiXpz8w3gbJppn8Q+2IVJ12UcbrpQ936IZQTLtWzW0Ad01sBfevIL7P3ca+5k5N8QzO3IQWY7VLvyh5pE1n+/4QO+CIwCQiG2Mp+4ohTVH+2ABxRWEjLxzB65N8R4iz6gBC41Voxib3u0t7reWNMRA+w9Vy7pIMdzgLZ5dLsC7hqfBgEuin64mKWm4AhHsVn8BKHuZnyUvHZh1FOLM3mAMp9EiENVbiDm2WyOzt3j0gtXeo39Av6vf96vwyN+U7sHeNK/dlMU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QWtZNnVHR0duWWx1WDltbkdsMjJTbE1nclphdjZ1aWEwNXhYbEZKZEpJSldK?=
 =?utf-8?B?QzdEOHF4N0J3eVQrMzFnVlR0SUNac2hHTWdDQWQ1dHFXU1p1cE85WVdyYjFr?=
 =?utf-8?B?V3Y5NkZVRWFlQVFONFhldEVGc0RSa3dSYXRLWUlPUDljYnpGYzlldlNGaU9m?=
 =?utf-8?B?dTQ3UUdZbFRkZnVBdDRUTEgvQVN3cmMzQTRQRUlMMjgyc0FaN1F4VVVwZG9E?=
 =?utf-8?B?TDRxcE04WUJ6TEh4SEhTN0dsVUE2eWUzR04rWStObXJ5MW1JTDFkM1pNNDJm?=
 =?utf-8?B?U2wwNWZKbHlqY0lEVDJ1T2RjelR5WG1EVFFrckNIc1RHYXQ1aVhkanVnRWFE?=
 =?utf-8?B?dkZ4WERVN3hmTTJXaG9IYThnYW9kMVQyZ0x1cjBHM3ZKcGt2UjQzODRqd3Iw?=
 =?utf-8?B?M1pVUEcrcUlSR0IwNkNnSmlJNDFNaDNvQm5RaTZzL3IybVdiQmxHemdtL2Iy?=
 =?utf-8?B?Ujd4MEZBYlNJVi9PaFMxWTJzWHJqWnptUXdHN2JGVHZDRG05NUVnQ3VLY0w2?=
 =?utf-8?B?WDQ5WVBqTjIwOXlRZ3ZybEpybjFPMCtaY1A5Y0RwUWluUG9SOGZHN0dQRmox?=
 =?utf-8?B?WGxjWkp4NVVnY3hzcTU2NkJ1Tk02aW5oaHNaUHNuR2xOclR0Y2Nyb0t0OG5Q?=
 =?utf-8?B?UzlMdUpZalFRaVNoTGNxekhXQTI3ODc5V1JSRWcwbTlDYXA1QWd4Uk5PU2tJ?=
 =?utf-8?B?ckFIUmo3MmhMVTBXdEx1VFYxbXpmUHBNU3duYytEVy9Gd2dJQ29RYjlGOUNX?=
 =?utf-8?B?TDlVOVlNT2Q0TDR5Q05vbkF0L2l3ZTgxWkgvbnIxK1JTcUhYZFZWdWdIR0xr?=
 =?utf-8?B?NE5MdmQrLzJZYlRBSWppRGd3NzcyckZsZzI4Z0J2QmlDWW9PVEo0MkkrR1Nv?=
 =?utf-8?B?dFVxZGN3YmtLcDdvTzlVY2JNdGhncUdPb1I3ZHA1ZGpBdE1kOXZuUm1yVDMw?=
 =?utf-8?B?RVdRdjVIUjlIMklwQWdvakhMVTZNQ0p5NklqdFRMK0g0VkVKOWdOS3J2ZUZa?=
 =?utf-8?B?RmhBVS9DTnFKakpOQy8zb2VZa2ZFYjdwK1gvWHpwV3U0bHNiRzVBRmhBY21i?=
 =?utf-8?B?bXBlbjJIOUJ1eXFHeitrTHVQTExadUVCSE1tTFBYUCtOL2FpSmpIR1VVdVhs?=
 =?utf-8?B?QjZtN1lHT1cwK3Y4S0NJYTdpY2s5RzBGeTZuYjdQUWdPS1orcVBHbGZWTThm?=
 =?utf-8?B?a0dZakV5REhYRU84SXdJdEpOUjU1NG1DbERzWHN5ZGlzWG5PWUxhUXk4UHp3?=
 =?utf-8?B?cjRpRWc4VitnbHhKaU1mdVZtRmVPU0FXMTBKSDNiZXk2cDFYODh2OUprN3RO?=
 =?utf-8?B?bkJtaEhGdHkxTjVTWGxmUjdmMnJocTBWTFlqbk05azREd0R6WlU0dTk4M3Rv?=
 =?utf-8?B?OHhsZ0x6Ui93OXZ4a0E5a0FpZ280RDZ4VGwxVk83Qm9BYktrd3VCcGo5dmlE?=
 =?utf-8?B?ZDNXbTJxUW0yWjhDL1R4TWRUYUZWVTNqNjY5V3ExWTEwTGt4WDVjdUJqS29o?=
 =?utf-8?B?SG9jbmx6MlVqQzljcDg3ZEIzZzVadEdHb3ZieTl1d2xwMVp5dS9GVFp2RnFy?=
 =?utf-8?B?V3MrMjRONFUwNzZ3RTh4bmpSUVVxdkExOUVlODlQYmZrekcxZlRpemc2NmNr?=
 =?utf-8?B?N2ZvaldTSW1KaGtTb25mR3k3TmYrcyt2ZGkzVWRYd2pDK3dkT3p6aGI1a2xj?=
 =?utf-8?B?MVlCRWRmNG5wakovajFrSi9HZS9jQnJIdlVDSW1hWmNDcDdlTWhneGlreXEz?=
 =?utf-8?B?dnkwY29NUE10UWgzN0xKMk1RU1gyVG9ka2Jnd3lTNEd4eGo1YWdHMm4rN1RN?=
 =?utf-8?B?eEpZSWFsc3RnZ3ZPTHh6SklqWVpMeHBJcmt5Z1hBa1N4YXJuMjRLTkhmMUkr?=
 =?utf-8?B?SW9MMEtvMS9sbUNJK1lNZHdMV09uU0VoRXBac2c2SWpXbmNuUkNKWTdNYk5H?=
 =?utf-8?B?SWxBUTl4MUhRYzlOTU0rQlc1VndQWm5HRVJNYmxGamdiK0VYK1VxWFBsejRV?=
 =?utf-8?B?bTIwMnBhMXpWV0tmZ3VKcjlLQzRFTDBUbTF2TnFZYXNwZjloNUVIdGYvOUR3?=
 =?utf-8?B?cngyVXVDQ2VtTnZra1RPclpCelh3YndWVjZzd0NCelE4K1hyODZodkFkTlZl?=
 =?utf-8?B?QlZHajJ4TXRmWUxmR2Z4dndvaGlaUWxmeXdCVU0xWVZuWThJck0wbzZrVlBE?=
 =?utf-8?Q?IKmXeoxg0w1d/jKyQRuLdd4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oSXr6sQ15RiNKMlKQxokxrxUvTmufy0VZ4j8Xj6S7spv5HnHOI9JmBG6HGLgqdELdUE+XS/d6ZLb4T1N3KeaK0WXhzbN6BOltSrdUUWG7lPbeFHexjHWkysaXka3I7sKGG9/DgKxA2OsausrGWANc8WvJfVc5KAAPSyzYYf+6hEoVSdy+k6bo3Mj4MLVvufEXYVbMbeuzx9QR6TP2WFnfkcDoxy8ebVRzqLm4QPWn3ngjm8BUBEzhLnmFhPqwQIXICmkEM/mO0YvERET0F02crgSAMBw5lutuFTaCHfAjiJz2a08mym+SiGWwfKiRtrv6xguuOMUvbdqclajMB6ZUd6YoXTkDChrh7b1xqeqLuyAaD6YNkwzoRBWxGovhoKCFz6CUy2NE4njyvH5n8eNpG9TPfMl/K2REbJb3bLKmt1oUOJjjd7CMYI1k7MB9VnOsdzmPLaHOl4LVS/uDYo0PBdyF8+fnuimqPY3dgFPMc0354QjcdsTI0lHDsWOhqrC4wB5BIvOF1uc1ErDk7OQorry9UiNc+7+lBQw9R5niyCTIDZlWA+VGLGNRxuUCu3TwO549RhzBSvSXgfii0vKL89uWi5I7oRB1rB3Oqlu758=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a3ba21-1b6e-4cc3-3ef2-08dc4cb12b05
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 09:51:39.6021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KB29EEv339XNqm/1FgD4ciutM66DFhGa+ij4vNUiNLcSdTavC64vCurEs2ri+4bHqMjB6uM+/QYG7RBedmKFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6053
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_07,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250054
X-Proofpoint-GUID: n623i6BkbTt6_9R_UePm1RgGLPX8PbI-
X-Proofpoint-ORIG-GUID: n623i6BkbTt6_9R_UePm1RgGLPX8PbI-

On 23/03/2024 02:50, Alexei Starovoitov wrote:
> On Fri, Mar 22, 2024 at 3:26 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> Support creation of module BTF along with base reference BTF;
>> the latter is stored in a .BTF.base_ref ELF section and supplements
>> split BTF references to base BTF with information about base types,
>> allowing for later reconciliation of split BTF with a (possibly
>> changed) base.  resolve_btfids uses the "-r" option to specify
>> that the BTF.ids section should be populated with split BTF
>> relative to the added .BTF.base_ref section rather than relative
>> to the vmlinux base.
>>
>> Modules using base reference BTF can be built via
>>
>> BTF_BASE_REF=1 make -C. -M=path2/module
>>
>> The default is still to use split BTF relative to vmlinux.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  scripts/Makefile.btf      | 7 +++++++
>>  scripts/Makefile.modfinal | 4 ++--
>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>> index 9694ca3c5252..c8212b2ab7ca 100644
>> --- a/scripts/Makefile.btf
>> +++ b/scripts/Makefile.btf
>> @@ -19,4 +19,11 @@ pahole-flags-$(call test-ge, $(pahole-ver), 126)     = -j --btf_features=encode_forc
>>
>>  pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         += --lang_exclude=rust
>>
>> +ifeq ($(BTF_BASE_REF),1)
>> +module-pahole-flags-$(call test-ge, $(pahole-ver), 126)        += --btf_features=base_ref
>> +module-resolve-btfids-flags-$(call test-ge, $(pahole-ver), 126) = -r
>> +endif
> 
> The patch set looks great to me.
> I wonder whether we should drop this extra BTF_BASE_REF flag
> and do it unconditionally.
> Currently btf_parse_module() doesn't have any real checks
> whether module's btf matches base_btf.
> All the btf_check_*() might succeed by luck even if vmlinux btf
> is different.
> Since .BTF.base_ref is small we can always emit it and
> during module load the btf_reconcile() step will be that safety check.
> Less build options, less moving pieces and doing it all the time
> will make the whole process robust.
> Conditional BTF_BASE_REF=1 will likely mean that there will be
> bugs that only few folks will hit.

We could certainly do it unconditionally for out-of-tree module builds
(the KBUILD_EXTMOD case); so anytime a user does "make -C.
M=path/2/module", they would get base reference BTF. With this series,
that would just mean applying this change:

diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
index c8212b2ab7ca..0322f8450a89 100644
--- a/scripts/Makefile.btf
+++ b/scripts/Makefile.btf
@@ -19,7 +19,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 126)
= -j --btf_features=encode_forc

 pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=
--lang_exclude=rust

-ifeq ($(BTF_BASE_REF),1)
+ifneq ($(KBUILD_EXTMOD),)
 module-pahole-flags-$(call test-ge, $(pahole-ver), 126)        +=
--btf_features=base_ref
 module-resolve-btfids-flags-$(call test-ge, $(pahole-ver), 126) = -r
 endif

So with this approach, in-tree modules don't add base reference BTF
since they don't need it, while out-of-tree module builds always do.
We could arrange for bpf_testmod to be built both ways perhaps to ensure
both approaches get tested in selftests along with kfunc addition etc.

For adding base reference BTF in all cases, I ran the numbers on adding
base reference BTF across all kernel modules and for x86_64 with 2667
modules. Base reference BTF adds around 4MB in total. Not huge, but for
in-tree builds, the only cases we've seen that triggered BTF mismatches
have been broken cases where vmlinux got built twice during kernel
build. So my suggestion would be to limit base reference BTF addition to
the KBUILD_EXTMOD case, and make it unconditional for that case only.

Thanks!

Alan
