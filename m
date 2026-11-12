Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.38.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794498864;
	b=ruWAnh5dJ/OXBzdGZ+I2tb26Mp4CzT0DhXnmbB8VNEaMSwRM//DC/4AI3yywWxbfcsS7
	 QsOHuS+DqiP2QNjx/pBmqove6YF5ECopr1dbBBw7Z4/G3sYHg7BBzdoBoR3NJXhgnLhj1
	 fqoh0tVZCy6uQ5C/oFKqnFw1WVYKSgJ6a+iW7OLAaNsU6TGXKQrT6R/w4dCLlUrCIToLs
	 xUMvJP1R52jdUfFrLRbymwMACsQvBaSuSWlyoPOaE06DrYABZf8tGgyW8WewO3Cveqmwj
	 3qwwmwAODFUOQNl8nR9iKzLd/m6e9PEHay28l6Iq4zLg0Nqz4TurZubAwvavDaFCM9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498864;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=JaGDZTaXK2CDaBCZzJOpa/xLS6UDBjDeNozWizymuwg=;
	b=SC6eaZLTckmrD/VzPKu0+dRuDIhh2+tnVMZEnijaIGXvXB1K4cJkkpRN7IuyAV/hyLBp
	 SaJzMrtoY9RSzhtT/sBQDTLwVnBFSxYDK8OGxDL98/qvTTKT/cVkC/opOYvTe62UD7f/b
	 HYp96AA5Q8x2X+pMknAAJZ63t4PgCfaFtjwhlYNBNkeNOzZETlZPXdjdzvbNPFsDvmxYu
	 0DnVK1zyxdLHH5mFtcwFc7hiEEWT/cul6nc290xieoSahzi26wqXTy9BP5aBTqRN6drX5
	 Bf1b8x5Fefks+CpLrkKXIZcFvkqk4YbdHB+24tQddKuFLEryrpf3DoQHC5DOEwUt7Tg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="Pe/EkThT";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.38.61
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazolkn19012061.outbound.protection.outlook.com [52.103.38.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8C0606A31C;
	Thu, 12 Nov 2026 15:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A8C0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Pe/EkThT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuC9iqHbwBa4N++xxwjAn3fq16O9xemvGS7+IceUPQ03z+WWqt7DAqGC2Oot86Yy2diltW8sSRup4Az14A/TIlDo1pJIURISbjvperUWcQQxS+HPkSieKp7NryEticnAJilUq+OX5Hq+4RZRISnREsnIULaTT9WJQZ4nzeNpQwgiXmbUM6hUQ2U+I0BU5i+XfSuIsNzuK89FCpkAtHrFtZlsIvKz51JKL7lyErl1+rRXK210wid+rBFVUkMaEIj2IzeEPkm54pmo/mmeoZ9ffb6ZaZnUcaYa7v27PD52bvvuNZOeZti45QnIOZ76YDoLukR7BTPUuYE0jAsM9a47pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaGDZTaXK2CDaBCZzJOpa/xLS6UDBjDeNozWizymuwg=;
 b=Jn5PYUV3a6WASc2JuWuc1WDlFvqguXRjrYJl/a1czxXBS/+a3lfmPKbaCxbuvLfVEFz0Gdt8HYxXkemgQRoTR69HHDyIyFhAquF67cf4ogksmA/JfK8WvpmLw9lNeB4OTycsMJ+Jy5m16zcz7UXJeIU3kwkLcdYFI8UQJsuSF1pZ2J5XGKPk3rBU6wirkBo8SGnkrFwDM/uGLCI3/3/vMvU9R+iRhwlFsTOIcaJ7RnhaxEM16BDQ9+9r/Zn2XHgW579aY6sKz61uN4rKZoSiO+XDItq65xeJMfkr+Au2yWP09Qw0Sue0IjFmJqr1lnHuA+KtBwum+AKe1hDDV6itlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaGDZTaXK2CDaBCZzJOpa/xLS6UDBjDeNozWizymuwg=;
 b=Pe/EkThT5/kzoG1RCvnSIoghgNkj2oh0bVDHBbZcMi804LaTUhAsDKiSU2A4mb4+FtMzx5ojHEy+k9zD+nZr7l3IpjN+XlOBqevLj7nQFTXOTmfP1Dc/XiRqcVnnnP9SxtuX6YO5TQigndDAOm31YZBqYMSNT1VpTfZYEAMZ/dbOHWq38Vd0VFVpOl764f3gP5Qd6Doaj/5LtISMy8sq2PLUoBDYgoD4JmQi8FgABM9Fe+bEgXl8CdTVyj0lL7nIljpt7eS/1BPihfvsz1JJWe8Uy3/xxH4iNzSE/ubHV6bXhtme6aftiUs9f65nwwDbSagwSos1LlSKCS4eSIoQsQ==
Received: from LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:378::12)
 by LODP302MB227602.GBRP302.PROD.OUTLOOK.COM (2603:10a6:600:4d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 15:54:21 +0000
Received: from LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM
 ([fe80::fa56:cf9e:33cf:e1b4]) by LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM
 ([fe80::fa56:cf9e:33cf:e1b4%6]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 15:54:21 +0000
From: Adethya Srinivasan <adethyasrinivasan@outlook.com>
To: bpf@vger.kernel.org
Cc: Adethya Srinivasan <adethyasrinivasan@outlook.com>,
	yonghong.song@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 0/2] Reject writable map iterators on read-only maps
Date: Thu, 12 Nov 2026 15:54:05 +0000
Message-ID:
 <LO2P302MB0197C0434BCC2A9031E99A18BC702@LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CW1P123CA0032.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:290::19) To LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:378::12)
X-Microsoft-Original-Message-ID:
 <20261112155407.136041-1-adethyasrinivasan@outlook.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P302MB0197:EE_|LODP302MB227602:EE_
X-MS-Office365-Filtering-Correlation-Id: baf2f2e7-bb0e-47d6-9c8c-08df40d53724
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|4140399003|260925184616899003|25010399006|24021099003|19110799012|8060799015|15080799012|23021999003|5072599009|12121999013|52005399003|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q+blu9xpkKf9QJLcb7rwqDU1Qt5idhJTwJb1wXjVD90caqXMa1K8fDSbJTuk?=
 =?us-ascii?Q?aortKZEz/HjEI4NqMxFyqnPxUCgqeLcmr8p7SML16VTqxHDW0H4pBxsWcJeE?=
 =?us-ascii?Q?dpe39v3dfpZ7W/mvdE9yY6hCH2G+AWwwh3h2Dk935nEYmhqSM7Tm2b3LHORK?=
 =?us-ascii?Q?ap7wzJNmcIKTDJNJW9m5RXAUTqbU3nynCsa5rS8L+vTObDn9YBN6z9KCnIk1?=
 =?us-ascii?Q?fp1Y8oQMiQiTs4ik7YD7SmIatzwAoXikpt0gXWPNV9WRYLKgBlttmgyeYp5J?=
 =?us-ascii?Q?i2z8SeND5VzsloQqqcZDrZWviyoKqz2vjGy3VAP+3udJTDSPPRMtOL9vtXTA?=
 =?us-ascii?Q?PiJfcIkRMAk1aBRyDf3xzCGI1ltve++JP+iVJzsOhaelWhH9+mQCEwIV1gHj?=
 =?us-ascii?Q?oxMkTSxvXoMINO/pKZZDG9kLtpQe2It05cNBnx9uqyefJDMWEqjziANxjPOt?=
 =?us-ascii?Q?uBmM9dY36dExqSWe/JdCWQHu2hxy/89jZEn96v8diWSsNSRmX6H7jpe+s7DZ?=
 =?us-ascii?Q?nrxU3Ow41cHI10qFMJ02vEIEVdmkS8MQvL8wSImMIoEt6dNMsTJ7QbtL1z5r?=
 =?us-ascii?Q?q8kJvSAh7tz8wkFneRT9tiJ32o22hbXRELxp8+f0B81tRFRNGWOZ3BQDg3f0?=
 =?us-ascii?Q?mgec7ZmvBIBRL959rlnKakMdb0X58VKAb4OlcAJ3f0vgXFktFO5noTyp3Kgb?=
 =?us-ascii?Q?Jn0qtOLDSawYdO0K+HPwjOlCLk017jjpuFyHLGjLRLBKH+3NrJBpYTMFwCxy?=
 =?us-ascii?Q?SdPqJ/FQ0dG1qbjTEndh0iGSAtgwvn54VIF7+AIms/OcrdFSOCWNVe0ErgaY?=
 =?us-ascii?Q?li3fDg50Wx5hkfKFwxG3mW8wSbKt3o/1bFutgmCNi0JQhz0jdH/M1AUDuWKN?=
 =?us-ascii?Q?R9FihxpywtmL4uVMBOqiu6abh3/KU4hMqdYaqgYax4VIy3t6qKhnWIFRYwS1?=
 =?us-ascii?Q?HHhZQmNlJ0zAuVEFva449kEJdGrREOWj4TgEF4BVBXn6/B0wIY6mHZOiuqYM?=
 =?us-ascii?Q?pO07?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k9arIpyDHVdQxgn+1YGX10rPq7dRufd0r0q3GyKlexiOhGC9xxR4r183gzvg?=
 =?us-ascii?Q?U8RzW8wdO/mK2iaR7IFbB1qNx5oodFu63615SLoZeueBxjVGrCcn3kEPwFSe?=
 =?us-ascii?Q?n17DjktXmyxDu5oeAgZc/Fgo2sQRtYC5n3MQidF0D1qauQcxA50EVE62J6V+?=
 =?us-ascii?Q?NqxtxuH4J82NumeqMe6JPFfE22uDXR8qo8NIPXNtH23Ftf2bwMwZMz/L7uuU?=
 =?us-ascii?Q?+NOXjEp7YtR7UxDzQXjKH4hjf54CZSWICUHrTvGDZrenpg+xU7EgapoeXy2v?=
 =?us-ascii?Q?1Df93wKE5fALvA7Rz9YX+xoS2iEE3Bsg5yyPOgTrmuZkE5t0+ni+eCi335yJ?=
 =?us-ascii?Q?J1pxhEKrmjOhW/a5ptz7SMvIzMTLKhmbZ5cDS2Rj+NZ1WoxLZQk0u1R0bOkK?=
 =?us-ascii?Q?YBbTUdtvxxrJFSH4jkl7uAYcgm0aUN+tQ2ZsuaOTout5p+y5c2AW8k/RUQ/m?=
 =?us-ascii?Q?Wks+yazReWpOTlMqt+JlyKcFDYf90P2OXUm+9fltpfyUU977eE3zx4X1anQQ?=
 =?us-ascii?Q?23xX/rH6iC7ttEGkl8zvnk8OC2pMGhsmtvmbshcy/uZrc85OEDZpT5QLdg5R?=
 =?us-ascii?Q?dwxTBmwqKNssxjb8VGfuEEGAkzDqSkKmQczyPzSdgr5eeYoTVoshc3db5BGB?=
 =?us-ascii?Q?pXt7Zj3G8kFPzjhPol3mDntNeHGZY9lkRy63NpfeCGqC0odulqO1mdR/IKhC?=
 =?us-ascii?Q?sCzMox/VCSKTsaBSzI+X1FE1hokS8EU7mb2ShFGVCW9jRtAeETjVosNyY9M9?=
 =?us-ascii?Q?bpKAwKbDkvjl2WNRxhU2joyQfkmN+xE3eyAq/Rg3aUffuY6uprcWFUc3KITf?=
 =?us-ascii?Q?LlyOiznV5L3UdF7C2jMBfcqLdoSwP2VjdjsZG+eKK67WP9L7KPzjiMKCifpu?=
 =?us-ascii?Q?gh06we0iayh+F9TScQ6P9grsnhsYPBybDirzJ8vlGVd/5gU1BM37zUJjBFqk?=
 =?us-ascii?Q?m/SiFErLdfwvFHNKxZFGoNeYz/0SuoGxv2D7SI3SeVQjY9/iFLdXaYy0n0uA?=
 =?us-ascii?Q?/iPmVy/C4nC3omv2LO8iMhmzUmVSQS3kS/5hWLiaXZ4meqy8NlYhsMX+4djq?=
 =?us-ascii?Q?hU6V2Y5Ru6kypfkaqld5sU3F73oI1kj5+JXa441j7t1bhiwvB1zG5A6MYoOB?=
 =?us-ascii?Q?ApOU8kB0RQH0VbRSysalAKT3GqR8Hfv+cj6dsnmJojRfM7uxCr9Sbm1jWFBB?=
 =?us-ascii?Q?t2I3JuxDBguYnoKvhzgpYnY9d7fIIB1zqNueO3gWELnm+nNsdPW7adu/snDY?=
 =?us-ascii?Q?9FkpVj2Ganxap7wAB8zxlNivwjg6jO9Gqj0pTozIU61La4jnkxF70Fr2b4UL?=
 =?us-ascii?Q?w/EXjxtGzTUgsGku7BNIjM4Gw+V21WXA0SB2sV4iw8zcxOufvdi4U4/olWWx?=
 =?us-ascii?Q?jvQNTwJJlu6iqIEN9NYU+LPi4+EYXZfhBE52mnOJMIP3AJhfXg=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf2f2e7-bb0e-47d6-9c8c-08df40d53724
X-MS-Exchange-CrossTenant-AuthSource: LO2P302MB0197.GBRP302.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 15:54:21.1755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LODP302MB227602

Reject writable map iterators on BPF_F_RDONLY_PROG maps and add an
attach-rejection selftest using the existing array-map iterator.

Testing on x86_64 under QEMU:
- Kernel and test_progs builds passed.
- Six selected bpf_iter subtests passed, including bpf_array_map_rdonly.

Changes in v2:
- Check BPF_F_RDONLY_PROG only; drop the frozen-map check.
- Shorten the commit message and correct the Fixes tags.
- Add a selftest expecting -EACCES when attaching dump_bpf_array_map()
  to a BPF_F_RDONLY_PROG array.

Adethya Srinivasan (2):
  bpf: Reject writable map iterators on read-only maps
  selftests/bpf: Check writable iterator attach to a read-only array

 kernel/bpf/map_iter.c                         | 12 +++++--
 .../selftests/bpf/prog_tests/bpf_iter.c       | 35 +++++++++++++++++++
 2 files changed, 44 insertions(+), 3 deletions(-)

