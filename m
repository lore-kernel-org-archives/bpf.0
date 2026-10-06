Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C173E9C17;
	Tue,  6 Oct 2026 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791312185; cv=fail; b=om5W0a5MUpSUbo8X/UiTPQEAQbZrz9Yu7e8QYQCQVyOBzwyeu48T379kof34jYrh8GUHT5+CwyO2hk9LsoVybOTxWt+65ayKh3V63yHJrsuUVL8P+w7iGPhiXn063aHEToVzmCXNlc08RcpW+fK+nlQCjzNsaVsk7FhLCszrvX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791312185; c=relaxed/simple;
	bh=FMNrr7UZbF38ck7nGrqnbeaovUXM1DJglSHjK7PeyAA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PEoCO8V/LEhEKl4QcqCPvrnz/3AwENoc4m9o65ZU14nb19nIgAQPmq2OmYN/wQ2jvCQrKztv8+cAfcZUX1/Cj7GfN2cJ0OcQvEiOkTnQZmg0m8bOrBVBUNln/2QB8BENmJj5cn3boTiUs/xkjBryZGlz5CypynwzPY+/HiASq9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c41/7RvZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AiCa5fKN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c41/7RvZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AiCa5fKN"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696FXmxJ281085;
	Tue, 6 Oct 2026 18:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+YWYO41qi6WLg6djY+KpUs70WE2BX7NmolLGdgQGse8=; b=
	c41/7RvZJEhmXEJSvPVf2eobFhkNSLkHexvfcDAiHpLRd3p1Odvn/kx9GzronuYj
	v/C7FM4kbR4ApbruzR4bdOZeAs/hHbnBYmfuEplkTeo9Ju9/9a+ja+ZHysVphs1/
	sEmS50FuyOGMXZOWgo6O22qaGEjXZoS2B+B90o5GGxnTaqDo5sO8S3aHgykyPPQJ
	SYh3lDCIePJI3MjKFCaoL7oQ/4hXksM9JjhpweXrrBeE/NAnBWxXyIhvb8wSgq6S
	OpYQZy3KyITLDKQygl6To0uz1BrdjCSe+OAbT5iTzKdQoLd4jHj3LrQHVtu7LyrU
	l+/ogJpHIBW6eVinRZ3/Hw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h2rg1vfv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Oct 2026 18:42:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 696IaTtV002133;
	Tue, 6 Oct 2026 18:42:26 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h4d0y1t8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 06 Oct 2026 18:42:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1Rv7BJ5eVy6HRG1G/o0gVI5pZVaMvdALeYKbUBg79OaGTnBsOXWFFWgXF6IeAkVFnBsHIxmolc3p7muhxtD3BJGpRrMXwlHcG3XpRPA5BCKTc1NKy+cMC/EWIlWkPqpNcPCx+J+InaH1KvF2gPugJf4J/7wKo+6H2N0CEVSvb7EYphzaBU4t99lujBRKp+Oc4/kneaj75y0FcwU3g8lTk37Ng3ZUuvW1K6KpQo2Q5RAwoOwTmFKuxkkbkaNfOvubiRQ6YaJTEIXCVHhU81eEVQnKkWfLU+RSy6FBiXcOd7DHLoXPk47uZ2gFrl5R3eTHJyI1J92s/QiZaE4Hj2lHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YWYO41qi6WLg6djY+KpUs70WE2BX7NmolLGdgQGse8=;
 b=Gc7HjZ87PbWhhvMegA2nDJSfCjbh8wZ6ewwDoBHzrtaf/vXjuGL+GUdOOBXH/DGzlEx0afvMy5FyWkOq1IMnSGj+7bbcRxul77WUdMWl72ZBzd+diKJoz6ujha1IGrWlqY+WE9BfCBLRmAtSXNOZy4l0U8EfotIUXTzsxe7h1gKAsMAV02w3bkN+qtn7oOhqX7xWerBWISDujTcqodVMmcqGb1ODMMW1f4HmKhpqq+gY+VDKLzilBuwLX+PYFUfRa1ohEU/kIouXVrGHicvSEkJLBuzYzDlA/fayAfeqAXtRAihCxYuoywnYdHekqbBWuY60l2jAWjFqZGLsQbhqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YWYO41qi6WLg6djY+KpUs70WE2BX7NmolLGdgQGse8=;
 b=AiCa5fKN5CwYOugUeXLVmDIFISy6NUxAdBalumpnMzT34sgTIlU9KucXF+5PWaLPO8e/fhthXOwRfvLapN5ygiX3F1qkMr7wrpl6Wa54WgmE47LrxCDuMrrHyAU3ZgmtgW24rf2LuTGQ0267YJUDxMROo/706SPfGbzPPDZWY54=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BN0PR10MB4901.namprd10.prod.outlook.com (2603:10b6:408:126::19)
 by CO6PR10MB5537.namprd10.prod.outlook.com (2603:10b6:303:134::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Tue, 6 Oct
 2026 18:42:22 +0000
Received: from BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79]) by BN0PR10MB4901.namprd10.prod.outlook.com
 ([fe80::19a8:41b4:f519:1b79%5]) with mapi id 15.21.0496.008; Tue, 6 Oct 2026
 18:42:22 +0000
Message-ID: <ba194e5e-6f7a-4c52-8ea2-3f51fd319f99@oracle.com>
Date: Tue, 6 Oct 2026 19:42:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 3/7] kbuild, btf: Expose vmlinux inline BTF
 through sysfs
To: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, eddyz87@gmail.com
Cc: jolsa@kernel.org, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
        song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
        memxor@gmail.com, emil@etsalapatis.com, mcgrof@kernel.org,
        petr.pavlu@suse.com, tj@kernel.org, kees@kernel.org, nathan@kernel.org,
        arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
        atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org,
        arnaldo.melo@gmail.com, bpf@vger.kernel.org, martin.lau@kernel.org,
        mason@kernel.org
References: <20261003194323.817885-4-alan.maguire@oracle.com>
 <970e7d2486a44d57b0bc68b9ac39c74e21e13df8957c952ec310c55a171115d9@mail.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <970e7d2486a44d57b0bc68b9ac39c74e21e13df8957c952ec310c55a171115d9@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DO2P289CA0006.QATP289.PROD.OUTLOOK.COM
 (2603:1096:790:6::13) To BN0PR10MB4901.namprd10.prod.outlook.com
 (2603:10b6:408:126::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB4901:EE_|CO6PR10MB5537:EE_
X-MS-Office365-Filtering-Correlation-Id: d5895f76-6897-44f8-8216-08df23d98eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|4143699003|6133799003|10067099003|260925022911599003|260925021311599003|5023799004|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	qkWOOK561cS2CTt5sUhNNFG4pz/MJvCLf+1gLr4OVRcR+4Iafgogn6nCSwsEOpFQRcvT9LpXZkhDbcaptP57R6ooqJmSVj1xH8L8T2YCUgBUfBzj2qPP8tLi7sIlhwWZ29HGBmw5l7HSAufvbL+aPMX0NkVZ6+sn26jVCkk6x610rtiTE35CCHJDhPvAzK1P7Av7lh75+zUluROMLNSDH/1MxihWohWmnxVTMmjqES+dZvFb+uWoves+rc0jCu6iWj3pBPkT6B4DqbC9cXjb3qtyqWXZTFWuHxOptf2/fb910ZhhHWmZyWv6CLawQG8iKzG5o2/cG0W0Wxdt7xKc39WtCruM9k8sMJMBnYVR2C4I6ICYXr07jetDyo96vmvK4mMEl10zFVgr1k5MKezvpi2MOZ5jmam8+FMMIbCoAk00zxD3WRZn+oEg1oUN/w7VAv5+o0rRcFKRI0ovYTx1W1Jy/1o7U6QS3aV+7kMkJay3uiKsKnPdr9IPJi0Upq5q6W8HzbS4UNO7F5XCHwn96gv+y+ACijs6e7d1AyNza2Up0gjJXQvuS9KQOUsoCLxmda6yDUXGrUlZIni+1WjS8i2DC9NkrKbUDdQCR6OCs6DVy0UA0a2jNiVeDUKuMfCAqaT+f7jakYXn/Kh04LVbyrjkp5wKrVzXxNHNjPDMfDw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB4901.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(6133799003)(10067099003)(260925022911599003)(260925021311599003)(5023799004)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUh6RWJoWDVOYkc2TUJCSzdKNk13VGlGUUxkMzVqOGJTSFlHaG9reDFuMmhR?=
 =?utf-8?B?RDEzbU9OQmdoVURibWQzbmx5Rkc5SkRMamhtb2RwL01vVXV2K05hV3A5RHlG?=
 =?utf-8?B?bWpCR2o5WTJTcjlSV3B6Y3ovUGVWWkw5TW96SGRzZXhMTGpTd1ZNcDBURW5q?=
 =?utf-8?B?R2h5RjFxWVV0SGlFdVg4UTlpUC9zZitULzZaOE9Ga3NtZHZTNUhjVzJOKzB1?=
 =?utf-8?B?d2orQnQxWDZJME9ZYWJSamxRbG9XKzVRT2UwUHhaMm9CYXVFdmtnRmJRV04x?=
 =?utf-8?B?dW9hbFpQVlVaWG40RFNRQysrUllTeUxha29obnhPRGlJWmo1NFMyTW84MUtD?=
 =?utf-8?B?dGV0TXZ4QXVSUWJjY3VYQk93Rm50aXRXUDZwUVNubHVGUnlJdWxITzd2dStw?=
 =?utf-8?B?bnVJdTlnd2R4dElVVzdTL0dlNGtWNitxZXJpVSttQXI0bTNwUXJydGdLMEVu?=
 =?utf-8?B?SG9wcTY2UlA1Wm5xR2F5Y1BoSlU5STFsRmJGZG13RTAzb2VGcEYyb2M1MnFX?=
 =?utf-8?B?WitycTY4VUQ5dk03SlBaM2xsWGs5bTBkL1k0T1hnWEtBOGY3VGRicDc5L2pT?=
 =?utf-8?B?WEoxSU5wS2pZU2VxbkdEdWtGSzdEZ1gvamYrdWhPZ1FTeWtRSVNnajhZLzlv?=
 =?utf-8?B?NmxES0U1MmdVbEhKdkU3b3ROZkdzOFUrSGhFWklQVWFJNjVvaEEwMk9yeEVF?=
 =?utf-8?B?SjA0R2w3TWZDaEMxcjMxWGFLY296emFGOGJ0WUs4eGhRaWRiWU11NG5Zc3Q2?=
 =?utf-8?B?TENwaGVvR21yQWxUekZMMWRvZ1U4OUVuMS9IeXJHYUtuVEl4dmZ5VGdJOGgw?=
 =?utf-8?B?OE1xTVkzWWVESmMvczB5U0ZQU2Y4M2lIbTYyMVVHWFJrVlE2Zm9OdmQ5NHlu?=
 =?utf-8?B?OThWRnUra1h5aU5xZ05GZkU4YytiTEZzQ3B6bHJKRmpLakFycUFLeGlybUZS?=
 =?utf-8?B?Y1NwUWNHMDZjR3pzSDhxK3JFMk5EQS95SUt6cUdxMkkySzVWZU5YbzJKL3lW?=
 =?utf-8?B?RmY3bnlvbUZMZU9HbTROOUhXYzAzRDNyOGd0bWRHem1ndWg1YTQzeCtyQVpQ?=
 =?utf-8?B?amhON3I4MVFReGM0SWljYUFaRVliRFB4U1pLLytCV1BvZGg0K2p5cFFJelZE?=
 =?utf-8?B?UE52WGk3Y1l3OExUbEFCRzYvMDlKUDQ5enMzek56RWRZRlRoTlNyVENsb3k5?=
 =?utf-8?B?MmxJVlpSQTJ5K1lzSFcyVjR3TnNybnpiYndkSGIvQWRlNTFRemk4Ti9LYTVx?=
 =?utf-8?B?YVMvdmZPSktnUUZLaXlETTdvTVUvMnBMWWVEa0hTWjd4K1RNVjRNakZIMlhj?=
 =?utf-8?B?eXQraWYzZWRVNzI4MERxYzZqMkJMa0FtVjVPWG9SQ2xjQnlLd05sNVpWWDBE?=
 =?utf-8?B?OFdoZjBIZDVPNDhlWTROWlpjbE1LZUtGd2NXNzBmSlpEM0hqbEhyWWhGZS93?=
 =?utf-8?B?N3NtRmt3Rmd1M3YxTFh5UjYzL1YxZGo1V2dUQm5FeTZHZ1p6bFdmQUQ4RlQx?=
 =?utf-8?B?ekx2dGEyZEVFMnJPaGw5cVBxTmNSRFRXTnAwdUp2enpuUWVuVitIS0NRV1Vm?=
 =?utf-8?B?dndpekhmdjZSV3NBa2RVaHJ4U0VEWENycnAwN0QvcnBEc3Jta3pTWmdVcUl4?=
 =?utf-8?B?aGgzRUNFNWRnTUc3dmRxYWllYWpHd3hzTDQraFA4NzJsNnV2Tm0vMzVRZW5y?=
 =?utf-8?B?QkhoTnlGaGxrTzVPV0hZdkQ5V0NsZXV3S3RjaDNNaFFCbWYrYVp5Uk5sN0ZY?=
 =?utf-8?B?TkNYUXRlQ0szd203VEw1WXkvUjIrelZtT0JnMTJPbWFXaGZaam1tNHU1eXFM?=
 =?utf-8?B?NzliRVQ5ZmRuWFF3S25IamxUcGp5ZlczcGswL0pSTGdrNFNWZzBqN2NwaThZ?=
 =?utf-8?B?NWdSOVlzSU9OTU03TFpad3BPanZkY0pqbTMzSmJWRC96WEFYaExVcWNvcElG?=
 =?utf-8?B?c2RIMCtIUmdRZlB1SHRrLzAwSm1YMTJ5QjByQ1lhQnNVcmtuQmU2c0R6bjBZ?=
 =?utf-8?B?ZEJOQkkzSkc0Vml3MmxHckpkeE1HWGxnaG9ESWpQaXhFY2hJMEErRU5KQTlr?=
 =?utf-8?B?Zjc3bXFSUE1UVXQzT2JuRGxjekxTcnRlaUFKWVVqaldQeG1ZSXJuUUlaS3FY?=
 =?utf-8?B?d0FzRy9HOHdVemZjNjY2ZUtQYVI1MGhwYnQzdmZVTGpQOEs1QXFMSWxjWjgr?=
 =?utf-8?B?c3ZyV3BHWm4vYXJaWHFTL2UvNUhja0ZSakVnTjRyMzhHR2VMRExHSjh3aVJZ?=
 =?utf-8?B?Rkw2TVUrSi9KSWE4UVRwNUpvOVBMTU9wRlhCVFZKNzNid2tKUlFMU3JWVEdX?=
 =?utf-8?B?dTlneEZkUkxjNlBqaTcxZWZxakRSdHIvL2hFd3dQRjBlTTFBcktPQT09?=
X-Exchange-RoutingPolicyChecked:
	lHqcOs4SVe7/xsq2J727PiBTwTZ0LqVf4NZEbkovgL8GsR6Cf2cWzh+WxL2caQrYp3U4pJdPqUpY+10CklXufKyS/RG9ani2Zu7CZ9F0ak/XG6No9H97VLFUQHCl3UTN/I0q+haP/hYQrfsFh6DLSlhZfHD1fPJ1SW5gnGVs3BT41BYtNuaP3bgvH6HuCvf20bCDCvFLxRpqz/oGJcWXKgS1d8hR7QK7rtPg6F8TxJWmCTaAJqggF1NGeUHfXT4Asd9kJIhv6N0h5zv7qv7p+YZ59WPHboAWNFFZp/XxEsm00VEr+b80/AJswoXf4RBR7bLmzSOwM05zF/6Xz0QwtQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZjXmR6EdciEPDFnxOXoaznYVSrKkwQSI5H5NWefsQ1FFhwjzUG4XpnocvYpLQC3PTbo0l5PVyEj3hcaoZuSq9RFpdLkpV2skz1JwCkTX3Mb5JXds443tHkKBhwahzdkWzE7AwUxCqk2MsCbqydIXWQ6+xqUZYWe8biuL9s4UTgzXcEEeqQZQYmlZKPh2v07Npic7+K0UH7peoMLpYHC87fXV2JuL3AD6lAdiwf0Bo9LCbVOtLziz0ilsNQOLBnSEHlygY9MJVg+cBX6tS+BcM2c0ku0KBSUgIsY79el6sTj9h27klZd0Q0Yvb57zMBqhcvCF3uliaWU+tOGMiRuZXOOlgykkud9e9MNAZqZJarzbyRpwSRpxGOothvfxvkc6bY0vj6HdtfQSknunV0xeGbZYP0eGH6e2KftEYazIOEdzDeTdulZTr3fGc+lo7tIsiFsA+doCwHbXMhBBZBVhzO2wVo5ELkLesW9NaIxKtRQtAfGMdba9gt7Ipw8XBqMVivtXWRK8vZL1Teq5YcM7apiX/OceZbrrurqD2Fm22LNptUzXxPmAGgEq9Zci5i8glkBQ+yr97nvxqEg/t9Aqgkqn7+3StKst5UivP0vXvHk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5895f76-6897-44f8-8216-08df23d98eb7
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB4901.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 18:42:21.9898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIDJdanvT1dt8H/SRvd7ctzzynG3rsv7W6HAr8H2Tul97x7NBAKU14vewMv556YgH8E45kiToeQssJ9RmMgZRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2609040000 definitions=main-2610060074
X-Authority-Analysis: v=2.4 cv=afj0Dhot c=1 sm=1 tr=0 ts=6ac54113 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8
 a=VRS8d96nyWgr1lfEtqwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3NCBTYWx0ZWRfXyVmAixc6rgQ2
 5Rw3lkalu9AGN/mDSC3RNigFBRrw/mUNjD8+ZdlwPDhlUtmpFSLS/VwtVcyNHO1y0XmOWFSWFbc
 OFSI/u7MZWMADlQkAoPh3UVe25Ai9pchu3+okwMcNcs6sRHaVWDgCntiY6PUhdynjg4e3zZeIt3
 el6HgutKejavc8T4yFRY8la9yl9XMh9ll53uGaCpLLT4usXMdsdJ3wHVyDNHLry4HfgnO7tNAzq
 UpvzSsRVTZPAY4Pex2LvZ44PVL4NJpf0j3DmuHgDSna4wpRqIg7zJm8cE9vvpLQHoTcwoECO1Xb
 09RG9GgPmDwJBa6vUzXWp1uVSsA9DSzm+0KjborqVcf8LOp7B6O8/ZIAtBJLP2IeualdIDGY/Uq
 8NkFxntye8efzi5+C8ntFAXrBLWSGkrMrL4/8k3i/y2gocvFiYwfGhrQV7FTFxn5tshGG12SANn
 C7sOwj1E53Vpkz1gTOg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3NCBTYWx0ZWRfX+DPFGUcCGU5f
 L8I057kZNAFi/TEExRfsZ4VLtHRrE2QJ+tXfzc0XeL7ZenmxhbdMcIP4FQStkCSqpCGyHAMs8t1
 RhjRQZJCJX8tWM+wpcBy3+QdGpgXkKWREBeuNmysI/wZmiEs4nzx
X-Proofpoint-GUID: OwZerczpNIOQOXjOKa3HPFELhgUDiZda
X-Proofpoint-ORIG-GUID: OwZerczpNIOQOXjOKa3HPFELhgUDiZda



On 03/10/2026 21:41, bot+bpf-ci@kernel.org wrote:
>> kbuild, btf: Expose vmlinux inline BTF through sysfs
> 
> TL;DR:
> - Module load may fail with -ENOENT for modules without .BTF or with BTF
>   mismatch allowed
> - mmap of /sys/kernel/btf/vmlinux may return -EINVAL on arm64
> - __SIZEOF_LONG__ may break 32-bit builds
> - Nits: .gitignore, NULL return
> 
>> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>> index b2988aa12f66..863f02660bc3 100644
>> --- a/include/asm-generic/vmlinux.lds.h
>> +++ b/include/asm-generic/vmlinux.lds.h
> 
> [ ... ]
> 
>> @@ -675,12 +675,39 @@
>> +#ifdef CONFIG_DEBUG_INFO_BTF_INLINE_MODULE
>> +/* __MODULE_NAME_LEN + SHA-256 digest + u32 BTF size */
>> +#define BTF_LINK_SIZE	(64 - __SIZEOF_LONG__ + 32 + 4)
>> +#define BTF_INLINE_LINK						\
>> +	. = ALIGN(PAGE_SIZE);					\
>> +	.BTF.inline.link : AT(ADDR(.BTF.inline.link) - LOAD_OFFSET) { \
>> +		__start_BTF_inline_link = .;				\
>> +		BYTE(0)						\
>> +		. += BTF_LINK_SIZE - 1;					\
> 
> Is __SIZEOF_LONG__ reliable in a linker script?
> 
> The lds is preprocessed with KBUILD_CPPFLAGS only.  On x86, -m32 is added
> only to KBUILD_CFLAGS and KBUILD_AFLAGS, and with clang KBUILD_CPPFLAGS
> carries --target=x86_64-linux-gnu for all of SRCARCH=x86.  So for a 32-bit
> x86 build with clang, or with a gcc whose default target is x86_64,
> __SIZEOF_LONG__ is 8 while the lds is preprocessed, and BTF_LINK_SIZE
> becomes 64 - 8 + 32 + 4 = 92.
> 
> On a 32-bit kernel __MODULE_NAME_LEN is 64 - sizeof(unsigned long) = 60, so
> sizeof(struct btf_link) is 96.
> 
> With CONFIG_DEBUG_INFO_BTF_INLINE=m, link-vmlinux.sh runs:
> 
>   resolve_btfids --btf_link .BTF.inline:btf_vmlinux_inline:vmlinux.BTF.inline
> 
> patch_btf_link() uses module_name_len = BTF_LINK_MODULE_NAME_MAX - 4 for
> ELFCLASS32 and rejects the section if
> 
>   data->d_size != module_name_len + BTF_SHA256_DIGEST_LENGTH + sizeof(u32)
> 
> Since 92 != 96, it prints "FAILED: section .BTF.inline.link is not a
> writable BTF link", returns -1, and the vmlinux link fails.  Even if the
> build got past that, btf_parse_link() checks size != sizeof(*link) and would
> reject the record.
> 
> riscv32 looks the same: -mabi=ilp32 is only in KBUILD_CFLAGS and
> KBUILD_AFLAGS, and the clang target is riscv64-linux-gnu.
> 
> Could this use something tied to Kconfig instead, such as #ifdef
> CONFIG_64BIT, or BITS_PER_LONG / 8 from asm/bitsperlong.h, rather than the
> compiler's default ABI macro?
> 
> [ ... ]
> 

yeah CONFIG_64BIT probably safest approach, will fix.

>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 0630675377aa..732ba0684667 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
> 
> [ ... ]
> 
>> @@ -9015,21 +9016,122 @@ static DEFINE_MUTEX(btf_module_mutex);
>> +static const struct btf_link *btf_parse_link(void *start, unsigned int size)
>> +{
>> +	const struct btf_link *link = start;
>> +	unsigned int module_name_len;
>> +
>> +	if (!link || size != sizeof(*link))
>> +		return NULL;
>> +
>> +	if (link->btf_size == 0)
>> +		return 0;
> 
> this isn't a bug, but btf_parse_link() returns a pointer and this path
> returns a plain integer 0 where the other failure paths return NULL.  sparse
> reports "Using plain integer as NULL pointer" here.
> 
> The only caller, btf_vmlinux_inline_lazy_init(), handles this the same way
> as the other failures and prints "invalid vmlinux inline BTF link".  Could
> this return NULL, or be folded into the check above?
> 
> [ ... ]
> 
>>  static int btf_module_notify(struct notifier_block *nb, unsigned long op,
>>  			     void *module)
>>  {
>> [ ... ]
>>  	int err = 0;
>>
>> -	if (mod->btf_data_size == 0 ||
>> -	    (op != MODULE_STATE_COMING && op != MODULE_STATE_LIVE &&
>> -	     op != MODULE_STATE_GOING))
>> +	if (op != MODULE_STATE_COMING && op != MODULE_STATE_LIVE &&
>> +	    op != MODULE_STATE_GOING)
>>  		goto out;
>>
>>  	switch (op) {
>>  	case MODULE_STATE_COMING:
>> +		err = btf_module_handle_vmlinux_inline(mod);
>> +		if (err != -ENOENT) {
>> +			err = 0;
>> +			break;
>> +		}
>> +		if (!mod->btf_data_size)
>> +			break;
>>  		btf_mod = kzalloc_obj(*btf_mod);
> 
> Can this reject every module that has no .BTF section?
> 
> btf_module_handle_vmlinux_inline() returns -ENOENT for any module that is
> not the vmlinux inline carrier, and the
> !IS_MODULE(CONFIG_DEBUG_INFO_BTF_INLINE) stub returns -ENOENT
> unconditionally.  That value stays in err.
> 
> The old code returned early with err == 0 when mod->btf_data_size was 0.
> Now a module without .BTF hits:
> 
> 		if (!mod->btf_data_size)
> 			break;
> 
> and btf_module_notify() returns notifier_from_errno(-ENOENT) from the out:
> label.
> 
> The same leftover err is returned when btf_parse_module() fails with
> CONFIG_MODULE_ALLOW_BTF_MISMATCH=y:
> 
> 		if (IS_ERR(btf)) {
> 			kfree(btf_mod);
> 			if (!IS_ENABLED(CONFIG_MODULE_ALLOW_BTF_MISMATCH)) {
> 				...
> 			} else {
> 				pr_warn_once("Kernel module BTF mismatch detected, ...");
> 			}
> 			goto out;
> 		}
> 
> That branch never resets err, so a mismatched module, which that option
> exists to let load, now fails with -ENOENT as well.
> 
> notifier_from_errno() sets NOTIFY_STOP_MASK, notifier_call_chain_robust()
> rolls back the COMING chain, prepare_coming_module() returns
> notifier_to_errno() == -ENOENT, and load_module() goes to bug_cleanup.  The
> module load then fails with "No such file or directory".
> 
> Modules without .BTF are a normal case.  scripts/Makefile.modfinal prints
> "Skipping BTF generation for %s due to unavailability of vmlinux" for
> external/DKMS modules, and the kernel.spec comment changed in this same
> commit says eu-strip removes .BTF when find-debuginfo has no --keep-section.
> Before this patch both cases loaded fine.
> 
> The problem is still there at the end of the series (e1c2367cf1b5);
> 3357b172196f ("btf: Relocate and expose module inline BTF") keeps the same
> COMING prologue.
> 
> Would resetting err to 0 when the helper returns -ENOENT work?
> 
> 	err = btf_module_handle_vmlinux_inline(mod);
> 	if (err != -ENOENT) {
> 		err = 0;
> 		break;
> 	}
> 	err = 0;
> 
> [ ... ]
> 

Yeah we don't need to keep err here so we can just check
the return value; if not -ENOENT, break.


>> diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
>> index 9cbe15ce3540..a3c54b5fe294 100644
>> --- a/kernel/bpf/sysfs_btf.c
>> +++ b/kernel/bpf/sysfs_btf.c
> 
> [ ... ]
> 
>> @@ -33,24 +31,149 @@ static int btf_sysfs_vmlinux_mmap(struct file *filp, struct kobject *kobj,
>> +static int btf_sysfs_mmap_direct(struct file *filp, struct kobject *kobj,
>> +				 const struct bin_attribute *attr,
>> +				 struct vm_area_struct *vma)
>> +{
>> +	void *data = READ_ONCE(attr->private);
>> [ ... ]
>> +	err = btf_sysfs_mmap_check(data, attr->size, vma);
>> +	if (err)
>> +		return err;
>> +	if (is_vmalloc_addr(data))
>> +		return remap_vmalloc_range(vma, data, 0);
>> +
>> +	addr = __pa_symbol(data);
>> [ ... ]
>>  static struct bin_attribute bin_attr_btf_vmlinux __ro_after_init = {
>>  	.attr = { .name = "vmlinux", .mode = 0444, },
>>  	.read = sysfs_bin_attr_simple_read,
>> -	.mmap = btf_sysfs_vmlinux_mmap,
>> +	.mmap = btf_sysfs_mmap_direct,
>>  };
> 
> Does this break mmap() of /sys/kernel/btf/vmlinux on arm64?
> 
> bin_attr_btf_vmlinux now uses btf_sysfs_mmap_direct(), which chooses between
> remap_vmalloc_range() and remap_pfn_range() based on is_vmalloc_addr(data).
> On arm64 the kernel image lives inside the vmalloc range:
> 
>   arch/arm64/include/asm/memory.h:  #define KIMAGE_VADDR (MODULES_END)
>   arch/arm64/include/asm/pgtable.h: #define VMALLOC_START (MODULES_END)
> 
> So is_vmalloc_addr(__start_BTF) returns true, and the call goes to
> remap_vmalloc_range() -> remap_vmalloc_range_partial().  There,
> find_vm_area() finds the vm_struct that declare_kernel_vmas() registered for
> the image rodata segment:
> 
>   declare_vma(&vmlinux_seg[1], __start_rodata, __inittext_begin, VM_NO_GUARD);
>   ...
>   vma->flags = VM_MAP | vm_flags;
> 
> That vm_struct has no VM_USERMAP, so this check:
> 
>   if (!(area->flags & (VM_USERMAP | VM_DMA_COHERENT)))
>           return -EINVAL;
> 
> fails and mmap() returns -EINVAL.  Before this patch,
> btf_sysfs_vmlinux_mmap() always used __pa_symbol(__start_BTF) plus
> remap_pfn_range(), which worked on arm64 since .BTF sits inside RO_DATA,
> between __start_rodata and __inittext_begin.
> 
> The same applies to the built-in /sys/kernel/btf/vmlinux.inline, which the
> commit message says supports read-only mmap().  The selftest
> test_btf_mmap_sysfs("/sys/kernel/btf/vmlinux") would fail on arm64 as well.
> 
> Would it be better to use remap_vmalloc_range() only for the lazily
> populated vmalloc_user() entries, for example from btf_sysfs_mmap_lazy() or
> by recording the backing type in struct btf_sysfs_entry, and keep the
> __pa_symbol()/remap_pfn_range() path for kernel image data instead of
> testing the address range?
>

yep, this is a good catch, will do this/retest on aarch64.
 
> [ ... ]
> 
>> diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
>> index 8ca96eb10a69..e638291753d0 100755
>> --- a/scripts/gen-btf.sh
>> +++ b/scripts/gen-btf.sh
> 
> [ ... ]
> 
>> @@ -83,14 +88,28 @@ gen_btf_o()
>> +	btf_inline=${ELF_FILE}.BTF.inline
>> +	if [ "${BTF_INLINE}" = "m" ]; then
>> +		if [ -f "${btf_inline}" ]; then
>> +			cp "${btf_inline}" "${objtree}/vmlinux.BTF.inline"
>> +		else
>> +			rm -f "${objtree}/vmlinux.BTF.inline"
>> +		fi
>> +	fi
> 
> With CONFIG_DEBUG_INFO_BTF_INLINE=m, this leaves a long-lived top-level
> build artifact, vmlinux.BTF.inline.  link-vmlinux.sh reads it for
> --btf_link, and Makefile.modfinal reads it later to embed .BTF.inline into
> btf_vmlinux_inline.ko.
> 
> The patch adds it to CLEAN_FILES in the top-level Makefile but not to
> .gitignore, where the other top-level vmlinux artifacts are listed
> (/vmlinux, /vmlinux.32, /vmlinux.map, /vmlinux.symvers,
> /vmlinux.thinlto-index, /vmlinux.unstripped).  In an in-tree build,
> "git check-ignore -v vmlinux.BTF.inline" returns nothing, so the file shows
> up as untracked in git status.
> 
> Should /vmlinux.BTF.inline be added to .gitignore next to
> /vmlinux.unstripped?  The later commits in the series (f61c6417ac15 through
> e1c2367cf1b5) do not touch .gitignore.
>

yep, will do.

