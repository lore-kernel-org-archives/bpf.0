Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021075.outbound.protection.outlook.com [52.101.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10E51A6830;
	Sun,  3 May 2026 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777821840; cv=fail; b=fZiVC3ChGGbebg+UPxWFfH52K1cF5ao0N5Ew9tsU6HPBiaN8USpVw7fD4ZhJF6Bgav4eVxGsElee17F/cdx4ft96U/6JFlHW+FYT1csTukUqALhdGlgcUxNRK/lMuK4DIJcCIcSeotvxlBUHfElIGQsciO0y618THbEpkW/dYhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777821840; c=relaxed/simple;
	bh=/5htAh7m51sDWuMcTvD+mn6EbPmQ990jOb1r8Iqy0ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RRYGOh16uFCzZjMhqp3+lEdIgGDvLpYC5KuB8RKPVBxf43SnCM4ed4gH9dAfxSajssxBound6HeLegmunlg4MpbJ7MDwOnxS+9blxt3ZPzO2cM342tngRl+ioIOBCwwzD3UbzB8qUYHE06xuQECOlrs2BHV88Zfi2mkXpRcJVtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmzTmdP5WTCAEN4jdrZEpChftMVdEbFYjVdgp/uUfjA6CrXtjc4+AuHim9X2TzHJpLeds3Y0z68QE5Q62ArvJQd+6n+QFqFWhFHxyJ2g7kAGsQ5p6xouUOsikcDBYxP8QrxtfZKzGANl4aX06ABNZ76ApXJI9kjMVyhAwd+ARG6ixHlvhq+aTngPq6o+gZQWC+/ZoiUEwR33mHgfF9p+68/JC6oFKmo7d6Nzy/Tuq21v2flxlRjzSrXfpQv4HqA9z9Lt/e3E3bnZAd7TuCC/FMVqLrswS9/jviaPKbe7Lu0yYp0SO7O5eVDtY8AdMKeFNrFxY9Ml1+Rek/JLQGapgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77j2RMKzKrhEgQ3RgHJ0BQeXprL+yipR47zt3XDKTPA=;
 b=VXRDFCZWP9J6fv7nD+7rGtGLA7tEPz/cDScPar96bdI/TsrBB7AC6GuUkcnuIMD+NVxdAlXhlOoMUuV/yDQE5daI20DGKsSg3fCy+uQZCACTzQ0sCt2VnZ8iJkreRQhCOv4ralsuTxaQevgpjZwx/sD+hVlIaRMhaKbzdMF1TcvwSVXHjghzZUIK7bQ++oNHcjBgaEK9OMbg90NHnGSVS0cFPk6LJ3RlwIwp91LycIu4YkE/qiw1UWBmGpYkoLM46jTeJzxoPzuWLO+RRLQZRFHIWrVQIBQWRK65XpJr8wWjUtF9tNxxk7AoUQW5i6KwAB2VrRv7SiQYV9Gig3yYhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO6P123MB6838.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:301::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 15:23:55 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sun, 3 May 2026
 15:23:55 +0000
Date: Sun, 3 May 2026 11:23:52 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: corbet@lwn.net, song@kernel.org, kpsingh@kernel.org, 
	mattbobrowski@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	skhan@linuxfoundation.org, jolsa@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	mathieu.desnoyers@efficios.com, neelx@suse.com, sean@ashe.io, chjohnst@gmail.com, steve@abita.co, 
	mproche@gmail.com, nick.lange@gmail.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
Message-ID: <wvpx3ur3zwoqi5uw7243mmgziq6llsxhzs4zsn3qceelober4c@qx5wehsd2jix>
References: <20260503035220.520479-1-atomlin@atomlin.com>
 <e456f0f0-5e49-4de4-9184-32ebc53cd0a1@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ktthgpn6mguhd4t"
Content-Disposition: inline
In-Reply-To: <e456f0f0-5e49-4de4-9184-32ebc53cd0a1@infradead.org>
X-ClientProxiedBy: BN9PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:408:f8::35) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO6P123MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 384393b1-00ad-4905-f665-08dea927fd61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	kkquSJu0EkB8AXcR9gCddkkMNXpaz//Vmg1uXrzsPkwud5z2eQ1R94o6is/s5xBlxkPPA0/Yf1xi5RfBAzS+btQytSKBggH4VYeBiSYUFJOsVHukf84x15Y5lF7AMRmmW4TweLRv53WQie5uMdpI9tkDKwW9i8jivJjeK77y8cmXoXS7KG91dxWIYCcbzLb7q+AT6Xh6zq1F8Ob1eRMhfiGHwq2xi9o5aU98FlY3UDsaiKFyC1shO+ihkzCpfNTRo/19ayLZgG+0hGkdZiU1oFIvwNCb9waUPpKDxreyJtn2AZcBW1xr4co97DAx0D32tQhstanjC8alEshMBftZPWQT20G9oAebHUwFqakx9b9fvi/SFwCPsSMzj0UWW4hac5kJ0i6d8y44KwL0KlJG53cq7i4ztaOmXUCN1XxoSyqom2c2lx0l3XXB8gk9XrKtFmGcd5EEgxXXcB/RFV6I3L0zDRCFCPkOPqVhvAQXdARmqUbelUp75vyMswSH2fbVxw7znHWydpq3ioN/u7acHuod3w9WMSe4GRD5+A/fYvqIJGi7pIOLD0YiUev0G8XmlxDuBFfRSvvROGzY3JmqBZN6nHz/81y2UH91t0ae/M++ogFzkDxCqp0aPpncw5imwgyrdeVVezI9Zb/KPGGQgGJpWEqBi1dNNssuZlcE4pD2rgEJr+JAAwUyeuekQNbL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU5RZHdhMUdUa2hFWG51UXVQalNqQ3JUelFXb3ptbWZSb0ZHVlp2ZmRJVkla?=
 =?utf-8?B?aWZhY0oxbk0wRFpSd1pnckRFK3RIMk44aUpTZGlqOUFqK2RIbWZ5ajUrcmw1?=
 =?utf-8?B?Rmtvd3VFSHVzYTJmdmdscXVkYjhKNDlCNmxodmI0VWNvbXJla3oyb0Z0Wkhh?=
 =?utf-8?B?OE4wUC9BRU5udlRGOTc0bU5INFh1Ym8xTitTVmRnV1FYMjN3WExkTTJVVnFB?=
 =?utf-8?B?OGE2TlhKeXUxT203SnlZRnJ2MSt5MWd4LzFqcU9MQzdUc0hGelZHaEFmajVW?=
 =?utf-8?B?MDNHN05xNGoyUVk1MVV6azIxczhsY0luQTE1ejRlT2hJSTZFTXZCMVJBYjdy?=
 =?utf-8?B?b0dqcWVEK3JJYUlzZ1BocHlIM1prNkw3US9PL1NDTzV5Qk1ZYzY0V1dENlov?=
 =?utf-8?B?NUtyQVFUZnB5MVdORHBOcmhaazhoYUpCZ3dzd2kyOWxoUkdpV3Q4bnJGb2xy?=
 =?utf-8?B?QkFEOHZFRndNbkFnUWRudU1BYzhpRnFtb0xMQXh6cWxGaUhVVnlsS25HK3FI?=
 =?utf-8?B?cFgzNzlkK1U3dkJaOHQ0Y1R4citZbGR1ZTU4TEdBRlU2NlJ3cUJnc2hzcHZ5?=
 =?utf-8?B?V3BueW1yQ055MEU5UkFtQlFEUGRPS2NTMC84Z1JHaGVBc21hbllzdzNyTTFz?=
 =?utf-8?B?UUZRcnN2R1BUcDZtempwWS9NbFZ2WGVMT1A2bkZUMU12eXVpZlFMcDFJZzlY?=
 =?utf-8?B?VnRiRkJsN3ZBaVNqbG9qMFBVSlVaS0pkR2YxVitLdlpFVUNqNmtQZG5nMVZ1?=
 =?utf-8?B?QW9RcUtnSFZQM3J6b290MXY2UnkrNjZnSUxYQmJ1L2pXbnR1OFFLZi8vV0NE?=
 =?utf-8?B?YkhGbjd5TE8welZ4Ulc5SjdhcGNBaFFqMzhCeXdkd2dJLzcwUEtyNTR1TVFG?=
 =?utf-8?B?MFhXMXhHV3hQbi9OYWU1QzJSUFdIazRsVXhxMUFiUUxjNDZqKzNhVlpYdzla?=
 =?utf-8?B?U2h2eEp4QmY0amVuYmk3aWw1NTBqOXdiUFo0aVpnNS9nZWU4dWh6MmFyM1RV?=
 =?utf-8?B?RHBQREpvNDNrZVJoU2N4WHBydHYybkJST3RRdVpsQ1N0NDUzelBNMVAzaHJs?=
 =?utf-8?B?eU53SmRWd0RPS002QzdLZTJQQW9wR1hCbXFFcGs0RFV5ZHFiM3Zjdk5ZK2VN?=
 =?utf-8?B?SVhlNFRNOC95OTBjeGxhVkFzZldxbG80OTJGaHEwZXhUMVU0ajRrUHhYNUhE?=
 =?utf-8?B?QUxBelE2YTdzQW9EamQ0ZUxQdDRtb0RZT3YwQ290Zzd5bkZ3d3gxYjg5cjBP?=
 =?utf-8?B?RGZTMnU4VXpOWlQvczRKTU45K2lBeHhFdkNJTDQwanFSRUVsWEJLRnJtS0dQ?=
 =?utf-8?B?U0NSbWU0bVhWSU5DLzFYNWN1WEtQdTcvNHNXMFdZamc2R0pVUHpIRm9qbFpS?=
 =?utf-8?B?TzU4MDNuOUg5UVpTdWZBeEJDV2pzcWZSL2g1eC9zM0ZpWDZpVk52QnYxNzZa?=
 =?utf-8?B?b0lJdDZabllicW1oSTRkaU9LRldqaGl0MzE4UVQ5UG5aNjBEVS9hbG90aU8r?=
 =?utf-8?B?bTZlUEVtOEdVYmxhcHFRb1NvNjViZ1YyUU1adWl2bUpWVEpHRHNkaS8wSVFp?=
 =?utf-8?B?Qnl4THpOMkFvbDFEdXdCRHdwUnBwWGRqbnIrQWE1bnc2TGU5cjhLbzEwY0pv?=
 =?utf-8?B?bHA0cE5Tb0doOHRFaFU3RkVJdVNrOHg4MGt6cjhaMVhzcHphcmtYMU03b2p4?=
 =?utf-8?B?ODQyR002UHJkMzBySk1XOVpkUG1VUGxZTWFIU1Q4SkZEa3JHNzNiV2RRZFYx?=
 =?utf-8?B?Z2RXSWZJNlBFQ0U4VHhnL0VVdnY4OUZNemREVmV1ZGt6cmdwTHk0TDFqenpt?=
 =?utf-8?B?aTFEeU1rSVBQNVlHYWpTc2R1cGxXdFV3eFovL3dQWWlGMHdGK3J5WGFKWko4?=
 =?utf-8?B?ZVQ1ckk4cHhQN0xWYUZTRzZuS215Q0IyQnAvWHVPTHU2dVJzNmFZZ1pYWGs5?=
 =?utf-8?B?RUJjOWd1dWNna0FoZXIwSFNnVUFYY1AyUDF4S0JzYW5qbjFLcUZ1UGFQYzRT?=
 =?utf-8?B?WmUrNGZhYkJVY3k4NDd6SmFQc05rRWcyTzUzNXFGTk5sdEkveFdIdmJKd2hQ?=
 =?utf-8?B?RzNSZlJwOGRSNXp2ZlpKNWIyWXN3SDdEdkloRVdsVUV1VHNMYzQvTFRRLzJ1?=
 =?utf-8?B?T0tpUldMS2oxcmExRGZ1RklLN3ZOblA5dmpMOFpWNktrM29HaFNDN0lzek9X?=
 =?utf-8?B?NkRJakFkbDIzVllVT3BWUEpvTi9yTjN1d1lvVDRhVmlnUG9PTyt4cXYvVDFU?=
 =?utf-8?B?aHNFZkNRcjlWOFNBdTZTdVUrQVZDR2p2VzBab2QwNW5oOG9DZXp2Q3g5ekRw?=
 =?utf-8?B?K29CbW45RnVIMzlOODNTOTVDS2kvNjNxZGttOU9DWTFadnRMSldNQT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384393b1-00ad-4905-f665-08dea927fd61
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 15:23:55.5259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dbrTn97GRiNHLFT3lWbqgGpsqW82jzAAV43BzH1dl1f89Wgn3R0UT9hEsv2uLuqJYa4ZTIhpkKASTaTpNYuaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6838

--3ktthgpn6mguhd4t
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
MIME-Version: 1.0

On Sat, May 02, 2026 at 09:29:27PM -0700, Randy Dunlap wrote:
> > + 20) ``V`` if an eBPF program utilising unsafe, mutating helpers (such=
 as
> > +     bpf_probe_write_user() or bpf_override_return()) was loaded. Thes=
e helpers
> > +     bypass standard eBPF safety guarantees and can alter execution fl=
ow or
> > +     corrupt memory.
>=20
> (If this patch goes forward:)
>=20
> In this same file (above), there is a little script around line 77 where
> it should be changed:
> s/20/21/
>=20
> Also please update tools/debugging/kernel-chktaint for this taint flag.
>=20
Hi Randy,

Acknowledged. I'll address the above within the next iteration.


Kind regards,
--=20
Aaron Tomlin

--3ktthgpn6mguhd4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmn3aIgACgkQ4t6WWBnM
d9bcNw/5AXLy3/piW6h3xQX8n5Oku+AbhNk/MainyEOLv3hxPkb8EbtwJkSAWAHH
tNYmr4GfkIfPb8ApzgZn820HfoLd7uVDBUU+tHj7WC3j6BspmZSxLHlR1iAxVeBY
c1ILtc033zGlvFYc5O+6nT+OmLKKqzI7aTZCwTLCPmaKe09bQlPO/UK/82nsl8+h
tkp6ruwHpfkWGUzlZ9WAnlGymIzZapDUeyAcEk1HrjNb2ntpkQIYs0A1oHWSQCro
X7i5uJgpyA8T9dBVMzS6pLts+4wq4wLp92C71nib9Fvsy5yAXpQVYALSaId9QDEn
oY94+1RKkmNjnNKP7wE8AZvq1NHXmFhdP8oJ3ULj8TqKT4w4eVrug1Qs0KIB6ylu
Q3UccG7Fhkm1/RgAVX+5I39BtZBTk6B73T81qtNgj76uY4dDmFb+IzQDxJBZAOT1
AdACk6cYxaiAE9bO8fWIZ9q6TELsjHTPatr/gMQPfO05m4tRfVw9Gcl0e8B04vkU
wxCVo4yIU/AZ4Pvs7AnEW59j/Vd4byqcxIqllGeR08pny0ACioZq3yDFCoO392hb
Tr7I11JO1vwSD6PlUbKzimDOUpUMJOSjTCSJBBknZSpS43ndVKv2RuLOPiHX7OmH
YRiLvnlwF8TlnCo6Xo9lOiFaEDYA43lsC7R+Ec+x0ECmXrhycnA=
=aPsn
-----END PGP SIGNATURE-----

--3ktthgpn6mguhd4t--
