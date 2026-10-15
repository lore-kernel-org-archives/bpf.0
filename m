Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D02541E7D;
	Thu, 15 Oct 2026 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792087390; cv=fail; b=Ho+fAkIV9P/3m1foXsf1o3o1zyhj/NlEiyTHwKt1L/LCa+JvxNclCyXoNxkQbTRf8Of6bixZmdhAC6tKEf7RDPB1xKXBEKKrb4DL4yyJQ3IIdLiGg84i8E/O14ShQLfrmgmtixS29vbfsLNnPbAkJs1aUeKZcO9i6iyN04/z11k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792087390; c=relaxed/simple;
	bh=ncbnQ+iakl9vM5hTrct+vETuelrzzZWTpzlY2BdVizc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oXHP5yCMlFhwn0hu9uW/kcE2pt1wSMfp0XUpQ/TRinGms2otjgZJ384xSV/MoyEhC+vrJ0CL54qHgaUC5uH08tveWmxxYo/yHRtWA1Td+5+fQ4vFcCmL6liZ3dCaoQsj56KoF+XYO+NMuXR2OBHzBQKkokrbW+IHdGYRbzW5vMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqGIRxhn; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqGIRxhn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792087386; x=1823623386;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ncbnQ+iakl9vM5hTrct+vETuelrzzZWTpzlY2BdVizc=;
  b=lqGIRxhnV7C+Msy2tS2N7P1E+BTJS2H8mx4ZhAF00OkkyyQn3DIGI3rb
   XDTowJ2NYH84BPrhp1daYyD4PIh038kq9dJlsFVAXrKZdkGGZu7sHLBxq
   MMFDMtfySOOuvWN6DHCQQbWIWuKM+ejIuIMCoHUCN2BzjZIThfpz3tJOQ
   JUn0lxe5PqJZFGTMU3mAQgU5Koq53M3/3s+/tm/Df3UHSqev3wnNntQpn
   2ZLKvYRCt7jJevQAxwrHuSF3/Ubp6/WBwjCTbjKvP0siflQaJrmlkIVKu
   +cwWGINnZf4ugGKipzt+MhdJd9c+axO4bpgYb980gb5bSfsc0NjXoGnE8
   Q==;
X-CSE-ConnectionGUID: xkULKGPBRTGfT7IaDaf4sA==
X-CSE-MsgGUID: 4YmdXPyqSp+fb/dWGYN7bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="877709"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="877709"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:03:04 -0700
X-CSE-ConnectionGUID: dF/gCt35RzizeyF52ptl0g==
X-CSE-MsgGUID: 2FzpDoBUTSeqcv9JyrRKKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2177613"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 11:03:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 11:03:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 11:03:02 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.5) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 11:03:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oC4mVOn4ZrTdXl2K19hsNoNkqwz8Z2lVstZalOEfdC60J6SArN4l78SjtYUcracuyZGB8Va6IrGg5Fb0DzbIScktwNfN7L4ABSED3ATJL5mOsAtkrXkzMop4/Tem/pVH6zR4k18fxlpk3BV58xqla2t/dmTQ7x7Q99C6mXdcDNie38lvG2jbLscuVHE3l03cUsDnN7KrceyL3FXtl3wXFHv+DK30wOa0/foScHUk6Vj6n38ld6bdNcdL9fsibtEl0cGZ2o2CWaYE8O3ckP1BcbUgaPTYBoQd2OvsjU6fhjyjUXzx3GHVu9W5KeS3uBzT/ww/RETFHD4Dbs3jV1fVqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4lUSwTLKL0ryEPYFejWWtjjbmRlZY99cNxP9YD7KkU=;
 b=SXc03L/huBG7NW/Wv1+UJ4dhMG+c2MK+3cN7/OvZyoG8JG/C4Aub6+QEaCKSfLBmWQQv9u7gbEsdOo7LILlPBcVAooDQnV7aKZeDEebiwtNRqDpTH6qAFIDplanwIDfoZNkVp/JbfXhhHt9kIr0cPsRvKOjr3r/gUBbNs7muJUJCkREAcZmPp5JwJR5bhSQKXgc9BqmT0hnp+8U5hX1b2pJ+WmlZ4tPgSN49mnSwriM8n2FvQPgKhXKdA5RPmLZE4HooPefyLABeXuYSHkcCu8H697/oOxS7seAb+5Z8wfW8jraanDJakKHvrbjGW0tsPegB5yp5k3pT/9O77VMQVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS4PPF3FCD980E2.namprd11.prod.outlook.com (2603:10b6:f:fc02::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 18:02:53 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 18:02:53 +0000
Date: Thu, 15 Oct 2026 20:02:41 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
	<rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>,
	<kernel-team@meta.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, Pavel Begunkov
	<asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, Andrii Nakryiko
	<andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<io-uring@vger.kernel.org>, "Mike Marciniszyn (Meta)"
	<mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, David Wei <dw@davidwei.uk>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mina Almasry <almasrymina@google.com>,
	<clecigne@google.com>
Subject: Re: [RFC net-next 01/15] xdp: Size zero-copy skb heads by their
 contents
Message-ID: <atEVQXajVzoWSFzc@boxer>
References: <20261002190018.696925-1-bjorn@kernel.org>
 <20261002190018.696925-2-bjorn@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002190018.696925-2-bjorn@kernel.org>
X-ClientProxiedBy: VI1PR06CA0141.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::34) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS4PPF3FCD980E2:EE_
X-MS-Office365-Filtering-Correlation-Id: bfbb244c-67e7-44cc-6156-08df2ae68856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|5023799004|11063799006|261009223027099003|4143699003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9w66xkZpAoi/ffTsEJ9Gy6fJxhUbxKWySGbEBa1xTB5PEqrWWfsN7N94Jk4UCZ2imsbC6Z6+6Z1l+tk402Axs1ce1npJ7t45tJMArU+WUQ6kxR2lylO5Q3wTabRbGFLMggQtZEff436UvcwKLFmTfLihTGVpK1Cer4nrTh+D+iEwGfVuNMnwW3lt+0Jy7W3qDuYpmj7yh1P/0w+u9Fii5JUwpv+URpl/zK6NpIAMSgT4N81Ph2F/s6f2J/Bh3ISI6mANQT25AtgTn4enIYgOp33bRAForm8y0ElhzcDjYvst9kKhntSSWD/E8jNlGEC24OM4z0Kvsn/mijR4xRE/ZtPNkKwAyJu/ZAhG6xS0zTLSr+s4OyFp1gNB/RMxvXNZUVPG/kEw9y2XsX4iWanddNOY1D/sydLqNsNOUzIUj0hD7XJZjqf7HRjkWHFjIItp8uu3QSkiVElyipPQ7PlogcJa79Y+Eauf5V2OkQUBEEEvxEo1H9275oFpfWckOWqEwKT3hkayk5c9xv4Ju+8QG98EwpPY0SwrMW5Uk2yGclBJMKDlIG6c/e1BrbVMcOm4MeFoLBWxtBn7KFBodMR1Wi3pG025bOC+VzK9OEHjIXONwLgjtINvBcKdrC3IaI2Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(5023799004)(11063799006)(261009223027099003)(4143699003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6wR6kfN18rzSxVhktSGcDL6lCPpVySWiputJbBDN2EPKjQaNBNvc+jveJ+?=
 =?iso-8859-1?Q?fbL/pAFpVx4coMfFy36YsHBE+HyjpaCrbS9dy7K151n4COTG8STNw07kNi?=
 =?iso-8859-1?Q?ekdOiHfpyeebSkAPnU/rt+UGsfNV+5NvpTitqAAqaeKIg4sqshz18z7tG/?=
 =?iso-8859-1?Q?gjdJjRTTvaPAgx6YWDVRxOfwL3O93LB9DuO2gwqWcWajsqwAp+92aktZ9B?=
 =?iso-8859-1?Q?soPrDVFgCz3Lr62CZfjWUU9w1vZsdlSYcxwcTnH7c4WmDfRfvmm1Lda1ZA?=
 =?iso-8859-1?Q?Z9nloprjpeP3gjLqk7ea/chhWPH4Um15mV++5ci788mW16mopNcu9ueVDy?=
 =?iso-8859-1?Q?cYM4n0w9gy8D/33MgjS0Ovc6wAFfqN9h4XO+LqWM3CASstzuR1DfR1p+Xe?=
 =?iso-8859-1?Q?8PZkmakoeWGoPP3LD1/sqMeaxr8gVPxQOZUy8PtSBiI5f/UBkHKr76IURk?=
 =?iso-8859-1?Q?7v8nDQK8WTGvmsK+p8DTItG8KqGeW98DeUDPR7lNGxaOvX467OPRYp2N1f?=
 =?iso-8859-1?Q?t1TljpRatCxtckPHZBxwO1X6cYkWgZhC6tw5xMxIZ1LqVE72cpIVuapDsY?=
 =?iso-8859-1?Q?EX35U50WOnyx/AUGPm8VwssW/aqK5qqBKIgnbUy7AsW/1m+Q3yvavHf4Vi?=
 =?iso-8859-1?Q?+U3v8tXKOjDYVR8PGb1YK780bx8SBhg5pwLPYa55x75SgmSIvIqYYNwIYE?=
 =?iso-8859-1?Q?f37L4eyDjMdo2F0ska6LU0KSLFnqW5XqXlQVngdZQwp6oSqysX2I6Zcrho?=
 =?iso-8859-1?Q?bEL+Ft3shp0JB1qdM4Oa4JEN8YkZCDGjnosDNUCZu0DiShNWjZ5JQcfWm3?=
 =?iso-8859-1?Q?MweceYdT4ygPGOhKa05va5+cFR0m2s5rTa8/q6peDLh4s9H6sNGLPyQ+2p?=
 =?iso-8859-1?Q?sXu1vwUX4o2ZirqW8uSSxY/fTBkygeoVEx/rHVPriybr3MwHlvqIb5ZJnr?=
 =?iso-8859-1?Q?lZ31X9DUdcDaDP5+2RZ1dBiFPc2Gq6JTvSvVrGjSreMrfEhgrcVbB/t025?=
 =?iso-8859-1?Q?3nJ/STms5XRPb9g23g6cG7p+gCRIJXeuiFqgr9rhggEv6x0T48+wAulz1U?=
 =?iso-8859-1?Q?skQNGTR/1IoNRiRf1TQGw5qWnMgf8WqaCMoQn6vGoLMOii952GixrRFS6H?=
 =?iso-8859-1?Q?1v5Oj05pMsOHcQcRg/jPTOCuFR+m1fnTA4xyswipJYTBteBKD7zbcPfzhO?=
 =?iso-8859-1?Q?zbGCSWS57XpPOCQ/K6SJuz82pIT9KTjGLui4yNkt9W7pkxyhr41ujF+T6+?=
 =?iso-8859-1?Q?tKlYAlTQjZOFypHpWbuvyeMt4DPkaRS+D0yedvulpdwy71SVaREg+Karep?=
 =?iso-8859-1?Q?x/+ogig2iumbOBFOZDCI1jqzGHWjM47PmHGB6z8QnFrHVzr2ARI2NSOtgk?=
 =?iso-8859-1?Q?LmMvF+vVYhnkf9bHUxyH6oiZppCrol7lhBRYVKoS3x08DXoq3ECByzdsn5?=
 =?iso-8859-1?Q?0iYf5E67/COvgBEyCOQcobfUF1QK9EUxruYqar9hmuoficEM2DYTdK2nne?=
 =?iso-8859-1?Q?oMsErrTKUSEf93ET3X7sFDp40JCzXQtBbIBCQq4Dr3q32b39o/5j3vLxuR?=
 =?iso-8859-1?Q?gTYQNNlI5zSDU76Eor6TDayQGbM0Nqd6lEi4MKrO1SS9X5a+oIltR4tI7f?=
 =?iso-8859-1?Q?RbAjpCEzQm1iucZLqU3vTVlVCzdR4/qhumvm9GcqkYp6brnAOWb/20vwL1?=
 =?iso-8859-1?Q?ePN4R1YaCTk1Y9l58e1q+pvLm2KUUP0lxsKzYWkLcFMhUw+RGKGOslfVZe?=
 =?iso-8859-1?Q?sc3ZgPwr1UBurqmKnVTZNfi59OLS5z8lRwtdAluFe+tRIa/7HmEYZbCZVI?=
 =?iso-8859-1?Q?86jgnSF90iECqylS+TEyjxfFEVnmjLc=3D?=
X-Exchange-RoutingPolicyChecked: W4E10VDg5iADnoT9//Nu1o9wdw0qnKAAGsJI1IiAYU6NtyzynbYdphr/LqVUxPTzLm7kifqyx1latRypjnWSryEp8bhUMq/82Lsnfi3GyuXu/nBLS3CrIopkDWRvU24iwk5MXT87sI+i8XEqXsZfzrjzzSM6DMSpPZcEPNf1ubqn7trcoNxC6Qk4ToapIlwUEmRmdZOMNTZD+fkcV/LLf5irKSCyT1Ghu6a+yJurC74W8saqJglJFkFAYtHmGJG8cDzCWiNiewWP8d3GvOveISelbWBxIKiIJ4+F2S8kq8A7+d7Qy6HbvPzvUsZZekGfJChypr/oV+tSRvpRToBbwA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbb244c-67e7-44cc-6156-08df2ae68856
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 18:02:53.0255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pl0eBHR48Mhdd9/f68lpqdfOYbeT/cD1L0He27+jR1CkG0go+I7VYKiKvmxBO/yT4hUKgZx30hVt9gxxY1sIGqb2uXk4P8tzE1mB/qq1ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF3FCD980E2
X-OriginatorOrg: intel.com

On Fri, Oct 02, 2026 at 09:00:02PM +0200, Björn Töpel wrote:
> xdp_build_skb_from_zc() sizes the skb head by the XSK frame size,
> which leaves no room for skb_shared_info. With 2 KiB chunks, a
> 1514 byte frame overwrites 48 bytes of it. Both copies also round
> the length up to LARGEST_ALIGN, past the end of the new buffers.
> 
> Size the head from headroom plus data, copy exactly the data, and
> drop frames whose head does not fit in a page.
> 
> Discovered by an AI code review agent. Reproduced on fbnic in QEMU
> with AF_XDP zero-copy from the page-pool series: an XDP program that
> adds metadata, grows the frame to its end and passes it gets UMEM
> bytes in the skb's shared info. A new xskxceiver test,
> XDP_PASS_FULL_FRAME, checks this and passes with the fix. The test
> will be posted separately.
> 
> Fixes: 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
> Signed-off-by: Björn Töpel <bjorn@kernel.org>

Late on the ball here, but I believe this is the case Clement reported and
we rejected it as the reproducer was OOT module.

https://lore.kernel.org/bpf/20260629072300.1664622-1-clecigne@google.com/

Should we proceed with Clement's fix then?

> ---
>  net/core/xdp.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 1d679e8fd649..386240bd24c9 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -709,7 +709,7 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
>  		}
>  
>  		memcpy(page_address(page) + offset, skb_frag_address(frag),
> -		       LARGEST_ALIGN(len));
> +		       len);
>  		__skb_fill_page_desc_noacc(sinfo, i, page, offset, len);
>  
>  		tsize += truesize;
> @@ -738,17 +738,23 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
>   */
>  struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
>  {
> +	u32 headroom = xdp->data_meta - xdp->data_hard_start;
>  	const struct xdp_rxq_info *rxq = xdp->rxq;
>  	u32 len = xdp->data_end - xdp->data_meta;
> -	u32 truesize = xdp->frame_sz;
>  	struct sk_buff *skb = NULL;
>  	struct page_pool *pp;
> +	u32 truesize;
>  	int metalen;
>  	void *data;
>  
>  	if (!IS_ENABLED(CONFIG_PAGE_POOL))
>  		return NULL;
>  
> +	/* The XSK frame size leaves no room for skb_shared_info. */
> +	truesize = SKB_HEAD_ALIGN(headroom + len);
> +	if (unlikely(truesize > PAGE_SIZE))
> +		return NULL;
> +
>  	local_lock_nested_bh(&system_page_pool.bh_lock);
>  	pp = this_cpu_read(system_page_pool.pool);
>  	data = page_pool_dev_alloc_va(pp, &truesize);
> @@ -762,9 +768,9 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
>  	}
>  
>  	skb_mark_for_recycle(skb);
> -	skb_reserve(skb, xdp->data_meta - xdp->data_hard_start);
> +	skb_reserve(skb, headroom);
>  
> -	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));
> +	memcpy(__skb_put(skb, len), xdp->data_meta, len);
>  
>  	metalen = xdp->data - xdp->data_meta;
>  	if (metalen > 0) {
> -- 
> 2.55.0
> 
