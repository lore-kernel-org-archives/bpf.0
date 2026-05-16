Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021121.outbound.protection.outlook.com [52.101.95.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FC03CF043;
	Sat, 16 May 2026 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778950910; cv=fail; b=mNd52MScaxvXYK8cyEtEeWL8W/1xKFt/XB+/2zdr3rzAXr0nUPLpjE9Drm3cJA4i4PTYpd840Y6XlbmSlKVs5uJgC8bQd1DCHNJss0sQFXgBdGDTP0XLIYOSu6tfHkNVeK8eMNGUIbCepler0mK8wONqDqaRgpt3eXJPiS2haYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778950910; c=relaxed/simple;
	bh=FOx9P4fJNfL7o89hq5tkyfahh2g/X5smY3P7UPXJQeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IkWiSkexr+ZLWNLAFn8P3qCMM62u3JcjslKXyrk2oBPswg7d/1AM66SlXxIeiPWq/ovFRd3XYnNM7g2klQiuZELHuUeeWJrqXQQRNW46uc0fRQMufZfZo6fXMTtGvhA4pzi1DjzkVmM52RCqzM4CLM2c7ayeSz3eGQrXNCVndyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTp/fZBzLIk+KnrYhvSPZwezDdu3/SHJDGH5mBFudE5Ia0K8h/yoYjYudInmveSrzO0bPQUPHPicV64dpO3rIdijIVWnVNJR7jQ/L5u7c8pm1eaYJhqhcSL65axVfzkbr1ZaLu58qiHAYWSGJZjmcPN7tW4xl6PfWxzis5AHlHIryDTOlRdsU6xloOmlNT2UwOv9uduW3mUYJgg1TsQPa2iuK4rYBK+7jRMcbvSgEe/YvZXkYGK0lBimilLzGM3XF+7yFtjhXbFpCjTxFDDYEH3POhSswy51MN3+YMS/hOYIPfaKXo2kCtJNNZuKhBxbaMOAf0TOicEmbl3Iuh6ILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Vu7bsaX5UNVilgcjLyvrxMNaw5y4Wuc5DTsOZAVz3g=;
 b=rdkQH+WkpDTQImqj+UAXKzraSpqU5u40QexKbGPbQs9tY644aE33Srh/l41MeZN6kY7gzMEniXblNFB69G0aNpapvupTXB8Xnpg6dD1Qdj+Nr6zGG77H3j4VFiyJgJpoAbk98w289LSTJNWTBtre45voBALYey05ZZ04JRmfAsb1DAOISv1sO4MeHuqBy288mRqLCg0FgG4BW8eVpv9Fifdv9+TJnlHjzRzVIJQCp/eq4nw0DJPSZdIauk6Cz8/2HjBT0ubjmHQtqmF4+i5boZRt0BdYnPk2a052weS7jXcLHqZuUPWRqNk/N2f9TmeNOspp7/2qzzScWagW95wYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWXP123MB3768.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Sat, 16 May
 2026 17:01:45 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sat, 16 May 2026
 17:01:45 +0000
Date: Sat, 16 May 2026 13:01:41 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, 
	Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Randy Dunlap <rdunlap@infradead.org>, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3] bpf: introduce TAINT_UNSAFE_BPF for mutating
 helpers
Message-ID: <ybwbwp6n7zxqcrimnbhwtejgubaaszfg5m7qehtmfcnaaomelg@ydk334j47gat>
References: <20260503164700.548164-1-atomlin@atomlin.com>
 <CAADnVQJ5fatNF4auH+a8E39zWMfja3rm4BM_xGcTnLX8uuCQ9Q@mail.gmail.com>
 <20260513111331.7bede512@gandalf.local.home>
 <CAADnVQL_sWznA+JJLdzP_ZdUgQeO7p-AGnOtx9=fXjH+PnRJBA@mail.gmail.com>
 <20260513112307.53e77312@gandalf.local.home>
 <CAADnVQLw+_NaOVeaKabuf085wNo_-6MAv8w0EDO3fBz3KCQT5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLw+_NaOVeaKabuf085wNo_-6MAv8w0EDO3fBz3KCQT5g@mail.gmail.com>
X-ClientProxiedBy: BN9PR03CA0937.namprd03.prod.outlook.com
 (2603:10b6:408:108::12) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWXP123MB3768:EE_
X-MS-Office365-Filtering-Correlation-Id: a2edfb89-767f-4283-a43f-08deb36ccf1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|4143699003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3Q6PeS0OjIkYhtAQXjrICCNZ9YjYmy0lqopcJG7y0Mq5FLKR5NqzezTSEcK+/YO7LwKCewIt+gp1KY5j84ulm4Q+e4hVC9R6ulousR1cV1xWHbVjS25QRJTrH9mLIHniwEDXzx62+TqS2pWYgMX8Kk3Rlmn3+YyO5BrYDknAGTY8PcdEuWjAKzbSHsCg1BBdHmhbUI/u/geZKTKI1j2ouZcsTwE4eD/D+TMkMBf5iupgAhmExPqdUtlsEHl+R/yo5HHy+NoKpJ7TYeYtavaUob9syj+SC6MOOFAJHxgyRvcs/nuyi1XgHkpe/MY3PkxKdPBGYQv3FOcKVYjJEzT/p1INVynn4TMKUO0vMTKyaXAuqkrWPyQFidfRroP9muwI/7DU2dUTI5szDYEJaOVM2Ace5+ol+Id2Gw15XmpeiUZk1D0IMWl/Qf28tDNCusqDEsqziCqrZpOii3vhnsuuXCfRHgooO6FhbwSLRQCWA+usV//G1AMQ/tZMujgPNAh87+gjWLv6UFtbEX4B7dDXBBzQ2w8FzQojzvohqPf9WyzNZbC1KuyKjhM6dbsemSmiPvNRLSK+BQWQHapAxpO118vuTfK8mg1xuoVZ20YP2dw+XukraAGXsC1szuHKLvEdMQCtqhg8P7L6h7vxaqczI9Ug9I0FsbcmBNiNVpyFqwa++IVbREBrZmaiwP554TBM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(4143699003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGZDYjVzdm5kUi8vVDIvM0R6V2hpNUU2Y3BCWm1iSWk1S2k5a0lRb1NYbExx?=
 =?utf-8?B?eW9iYVF5KzlOV2NHY2lxTXRoUWo3MVFwZzE5T3QwN25PWnlOWStuWFl0N2NK?=
 =?utf-8?B?N2taZ1AwSlBoNDR1dkpwTEZnbXd0ZVNoYUcxVXZ3dUdnVlZBRUtnT3FjSDBx?=
 =?utf-8?B?czFKSUhUSVBCZnNaUEJ3TjVFdGlmSFd0YzlvMkczZUxwUWVaNmZDbkUwU3No?=
 =?utf-8?B?TjEvVGVONXk4amh0MnVqVXd4NUJ0b1BvS2JTdXhBVTFJOFAwREVJV1VCN1BO?=
 =?utf-8?B?ZTl0QjZZdG9ma3E4R3dOMDlLVDl4bUpCQmtYTVhjYWZaRWVtSFRRRGVVL0pI?=
 =?utf-8?B?SUIxeWs0ZzFJTFhRZW9ZSVdsMUJaNlhFSy83cm1MS3A1RVlaNkJvdlErYStj?=
 =?utf-8?B?L1p6cWN0WVRXdkpkOVdxeCtncVFxK0RkTmJwTjRNcjlIeGxkWlMyVFU0OVFM?=
 =?utf-8?B?TWc2emFwUWFFbVpxb2NjVnN5dm9EdVA3MmoxZEJKeTJQZlFWVjVyZXdIcUlq?=
 =?utf-8?B?b25iTHVHNmF2cEZvRjBXR2VldTBJODh3a1dzYmxuZmZvSXFPejRYSFExY1ZN?=
 =?utf-8?B?TS9jeGlEMm9iVHIwSTVZNEV3bS9LUHBpS2d0Q3B6ODJMR1h5bEFOVkh1UGhq?=
 =?utf-8?B?VWlEQ1RHQ2hsOGRZbHBlU1ZSM3E0bDJDUzFicFMyL29sWWZtbEp6aFJ1M2ZK?=
 =?utf-8?B?MVF1SGx0NUQrV2NYRzVnSW1yVFJ1STRnZlk5WFNjMnVDS1dqUGZqTGVqdDFH?=
 =?utf-8?B?S1JvanBlcmN1dEFQeTBSWm1BS1dBRit0ai9sNytZSFBLOG51eXlVRUcrU3Zm?=
 =?utf-8?B?U3lWL2pJRU0xN2xXbExoazBwUzRremlxbEJkQTJxYStpOTRmaFMxcGkzdXVi?=
 =?utf-8?B?Tk5GSUV4em50MGpuUE40aHFna0l6VWtEckFiUUpka29rbmtQY1dQbmZ1cUNL?=
 =?utf-8?B?UmpDRUdMcU9pT01iL08zVzNwWEVVZUVoRlpYNDZnZWpUREo3L3hmdFprTDZR?=
 =?utf-8?B?dGJzL2tjWlJqbzM2MlQzTHMxWjI4NGVOSnM3Z3RNc2NxY2dFVmhXNXN6SlE0?=
 =?utf-8?B?WHNoS0hOcGpwMlBSR0NXM25QV2pmWG5ubzh0U2ZHOC9rOU5PeVVGUEgram1q?=
 =?utf-8?B?QnRTMXRMWDk2T09ZeTlqZ2N2aTV1dkx6eVhiWWxacTZrTHBEQWVRb093V0Jw?=
 =?utf-8?B?NEI5Ui9oV1l5YmJzY2VhTjdiRzc3Y3NOV29lNzdqNERIQkdHcGZpVTdEZFZ6?=
 =?utf-8?B?a0dCcGgzNldlZDJVZytmN3ZVQUdGQk9UWGdHTkV4bVpIOEVyVDJWSmR2dzlj?=
 =?utf-8?B?WUJiZFQwMmtzTVRGbXNadk1BeERDV3NuTTJmVlIrMDZRQzlEMExtUjV2a3NT?=
 =?utf-8?B?czYrcHU2eVR6QkpJdTBaRkNoQTBWV0o5a0pXdTduOW5xQzBWRDA3aWlja05q?=
 =?utf-8?B?cDVCMzZOWGtKVmliVFFFWDQ4WHF0YW1QbDhBNDhxSUUxeDBscUlibDNaMkxO?=
 =?utf-8?B?b3d2YnMwODY0OXpNS085dzAycE9xeFhoQXF3NUs3SzNqUmZHcDYzallHN3E2?=
 =?utf-8?B?S000MGQ4dmwrWlBiM2czQm4zUU9reERJbFVYcTB3R2wrN0lVRmhxQk55citn?=
 =?utf-8?B?eWxDWldieTY4Z1hEU0UyTDNVVFJieHVZZXFTZzZGS2dUa213akZVRzBmMzhM?=
 =?utf-8?B?T084eTRGTnhxbGo1WDQrbTArZEUwSXgxRDA2Ulp3UmdGaGRvaTkrLzhVR1Vt?=
 =?utf-8?B?RzA4RFN2enkwNEJSOGpyVnNBUUs1SC9jNWkvVXgrcmhNbm5ZMkZqYUwybk43?=
 =?utf-8?B?SWdBdHpHUmovZGcyZWg4Q0QxanpaaDYwSUo4VGpWZGNUT0R0WjZBczdxRkxs?=
 =?utf-8?B?TWRBSEw5T0dqbFV0QllpU21rNzNGUUxhTWIrVWhHVVIxNlp6YlJIS0FkK0Qy?=
 =?utf-8?B?V1BUWkl0aUpLcXlvdzBBZzk5MGd1bnJCbk5CTzJMMkJDZlZvRnVtWTE1bjFs?=
 =?utf-8?B?QW9HNzEvQTlwcXRBZEpNTU5pS2VJTlYyL2pZMDN0eGNESEhzTS9qS0JJR3BH?=
 =?utf-8?B?WS91ODVQcmpOb0VnNk1MamNqVkRTZDVoNGNlUWlmdkJaelFnYTA3NlN0VjVY?=
 =?utf-8?B?UXVSN1dZZTZnM25TVFA5bTllYTljOVlUK3FoTHpQZGtESm9Ea0lVU3I1a0JX?=
 =?utf-8?B?U3FoalBzYkg3T1JtTDNYUjBzSWozZWRyZzNhVzVyRmRKL3ZQOVFreUE2bGpl?=
 =?utf-8?B?M2Z5TFZKYnZTdzBTSkIxY0VXZnRHVHZJbm1rWDZFTE52MGhQSWdmQXIxaDM2?=
 =?utf-8?B?eTEwcVY3d3FyZVBONktkL1QrRGg0d3liTTBTK0h4UGJDcjZtSmRKUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2edfb89-767f-4283-a43f-08deb36ccf1f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 17:01:44.9726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfBKWktrulpkI8GpTT4HJQpsJ0MXYdRx93WJMsyn1l/WPrw22UaFlHFqO3/hsHyZ7Zx2dtwtui4NIjTBzeSIdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3768

On Wed, May 13, 2026 at 09:35:29AM -0700, Alexei Starovoitov wrote:
> On Wed, May 13, 2026 at 8:23 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 13 May 2026 08:16:07 -0700
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > > It's impossible to track all modifications.
> > > See what sched-ext is doing.
> > > What does it modify? Everything.
> >
> > What about just having a list of what BPF programs are loaded, what they
> > may be attached to, and what kfuncs they are calling?
> 
> Ohh. These have been available forever.
> Just bpftool prog, bpftool link, bpftool prog dump xlated

Hi Alexei,

Thank you for sharing.

Kind regards,
-- 
Aaron Tomlin
